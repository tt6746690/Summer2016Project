var express = require('express');
var router = express.Router();
var pool = require('../app.js')
var async = require('async')


router.get('/', function(req, res, next){
  pool.getConnection(function(err, connection) {
    async.parallel({
      links: function(callback){
        sqlstr = "SELECT CONCAT(ENTREZ_GENE_ID, '_0') AS source, CONCAT(INTERACTOR_ENTREZ_GENE_ID, '_0') AS target, Y2H_SCORE AS score FROM Gene JOIN Transcript USING(ENTREZ_GENE_ID) JOIN Y2HWTInteractor USING (REFSEQ_ID);"
        connection.query(sqlstr, function(err, rows){
          if (err) throw err;
          var links = []
          for (var i = 0; i < rows.length; i++){
            links.push(JSON.parse(JSON.stringify(rows))[i])
          }
          callback(null, links)
        })
      },
      nodes: function(callback){
        sqlstr = "SELECT DISTINCT CONCAT(ENTREZ_GENE_ID, '_0') AS ID, HUGO_GENE_SYMBOL AS Name FROM Gene JOIN Transcript USING(ENTREZ_GENE_ID) JOIN Y2HWTInteractor USING (REFSEQ_ID);"
        connection.query(sqlstr, function(err, rows){
          if (err) throw err;
          var nodes = []
          for (var i = 0; i < rows.length; i++){
            nodes.push(JSON.parse(JSON.stringify(rows))[i])
          }
          callback(null, nodes)
        })
      }
    }, function(err, results){
      connection.release()
      console.log(results)
      res.render('interaction', {data: {links: results.links, nodes: results.nodes}})
    })
  })
})


module.exports = router;



  // sqlstr = "SELECT CONCAT(ENTREZ_GENE_ID, '_' , CCSB_MUTATION_ID) AS source, CONCAT(INTERACTOR_ENTREZ_GENE_ID, '_0') AS target, Y2H_SCORE AS Score FROM Gene JOIN Transcript USING(ENTREZ_GENE_ID) JOIN Variant USING(REFSEQ_ID) JOIN Y2HMUTInteractor USING (VARIANT_ID);"