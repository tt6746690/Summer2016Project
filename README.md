
EdgoDB stores and presents experimentally derived interaction and localization data for rare disease variants delineated in [_this_](https://www.ncbi.nlm.nih.gov/pubmed/27267344) paper, created as a side-project for the [_Taipale Lab_](http://taipalelab.org/).

EdgoDB is powered by [Nodejs](https://nodejs.org/en/)/[Expressjs](https://expressjs.com/) as backend framework, [MySQL](https://www.mysql.com/) for data storage/query, [Pug](https://pugjs.org/api/getting-started.html) as the templating engine. Additional data from external sources were either obtained from a public API, or via [web scraping](https://scrapy.org/).






----

#### LEARN

[_Stanford DB mini courses_](https://lagunita.stanford.edu/courses/DB/2014/SelfPaced/about)   
[_WIKIbooks: Data Management in Bioinformatics/Data Querying_](https://en.wikibooks.org/wiki/Data_Management_in_Bioinformatics/Data_Querying)   
[_CSC343: INTRO to database_](http://www.cdf.toronto.edu/~csc343h/winter/)  

---


#### DBs

[_CCSB: ORFeome_](http://horfdb.dfci.harvard.edu/index.php?page=orfsearch)   
  + data in compressed fasta downloadable     

[_HGMD: The Human Gene Mutation Database_](http://www.hgmd.cf.ac.uk/ac/index.php)         
  + cant bulk download data pw: HGMD364869   
  + `curl -d "username=pq.w869" -c tempCookie http://www.hgmd.cf.ac.uk/ac/gene.php?gene=A4GALT`  

[_HGNC: Human Gene Nomenclature Committee_](http://www.genenames.org/help/rest-web-service-help)             
  + good RESTful api, queriable    

[_HGVS: Human Genome Variation Society_](http://www.hgvs.org/mutnomen/)           
[_1000Genomes_](http://www.1000genomes.org/data)   
[_OMIM_](http://www.omim.org/)  
[_UCSC SQL database_](https://genome.ucsc.edu/goldenpath/help/mysql.html)  
[_pfam SQL database_](http://pfam.xfam.org/help#tabview=tab12) and a good [_wiki_](http://wiki.christophchamp.com/index.php?title=Pfam)  

---

#### Useful packages/libraries and resources

[_BiomaRt_](https://bioconductor.org/packages/release/bioc/html/biomaRt.html) and [_R package doc_](https://bioconductor.org/packages/release/bioc/vignettes/biomaRt/inst/doc/biomaRt.pdf)   
[_Ensembl VEP_](http://rest.ensembl.org/#Variation)  
[_Python: HGVS_](http://hgvs.readthedocs.io/en/0.4.x/)   
[_Polyphen2_](http://genetics.bwh.harvard.edu/pph2/dokuwiki/faq#automated_batch_submission)  
[_FoldX_](http://foldxsuite.crg.eu/)  
[_Suspect_](http://www.sbg.bio.ic.ac.uk/~suspect/)    
[_MySQL DOCs_](https://dev.mysql.com/doc/)  
[_MySQLdb_](http://mysql-python.sourceforge.net/MySQLdb-1.2.2/), [_brief summary_](http://mysql-python.sourceforge.net/MySQLdb.html) and [_short tutorial_](http://www.tutorialspoint.com/python/python_database_access.htm)  
[_Google Fonts_](https://www.google.com/fonts)   
[_Stylus Docs_](http://stylus-lang.com/try.html#?code=body%20%7B%0A%20%20font%3A%2014px%2F1.5%20Helvetica%2C%20arial%2C%20sans-serif%3B%0A%20%20%23logo%20%7B%0A%20%20%20%20border-radius%3A%205px%3B%0A%20%20%7D%0A%7D)    
[_Jade/Pug Docs_](http://jade-lang.com/reference/) and [_cheatsheet_](https://naltatis.github.io/jade-syntax-docs/)  
[_TypeAhead + Bloodhound_](https://twitter.github.io/typeahead.js/examples/) and [_Typeahead Doc_](https://github.com/twitter/typeahead.js/blob/master/doc/jquery_typeahead.md)   
[_Biodbnet_](https://biodbnet-abcc.ncifcrf.gov/webServices/RestWebService.php)    
[_RMySQL_](https://cran.r-project.org/web/packages/RMySQL/RMySQL.pdf)   
[_LiftOver Tutorial_](http://genome.sph.umich.edu/wiki/LiftOver)   
[_pyliftover_](https://pypi.python.org/pypi/pyliftover)  
[_Mutation needle plot_](https://github.com/bbglab/muts-needle-plot)  
[_Docker Hub_](https://hub.docker.com/explore/) [_some nice example_](https://docs.docker.com/engine/tutorials/) [_DockerFile explained_](https://www.digitalocean.com/community/tutorials/docker-explained-using-dockerfiles-to-automate-building-of-images)  
[_Go by example_](https://gobyexample.com/)
[_WebGL protein view_](https://github.com/biasmv/pv)  and [_doc_](https://pv.readthedocs.io/en/v1.8.1/intro.html#getting-the-pv-source-code)    
[_swiss model for protein structure_](https://swissmodel.expasy.org/interactive)


-----

#### FAQ

[_How to create an SSL certificate on nginx?_](https://www.digitalocean.com/community/tutorials/how-to-create-an-ssl-certificate-on-nginx-for-ubuntu-14-04)    
[_What self joining accomplish_](http://www.programmerinterview.com/index.php/database-sql/what-is-a-self-join/)   
[_Differences between identifying and non-identifying relationship_](http://stackoverflow.com/questions/762937/whats-the-difference-between-identifying-and-non-identifying-relationships)  
[_What is mySQL varchar max size?_](http://stackoverflow.com/questions/13506832/what-is-the-mysql-varchar-max-size)  
[_How to implement one-to-many relationship in SQL_](http://stackoverflow.com/questions/7296846/how-to-implement-one-to-one-one-to-many-and-many-to-many-relationships-while-de)    
[_What is SQL Server Indexing_](http://odetocode.com/Articles/70.aspx)  
[_What column generally makes good indices_](http://stackoverflow.com/questions/107132/what-columns-generally-make-good-indexes)     
[_Ensembl vs. Entez IDs_](https://www.biostars.org/p/16505/)  
[_CSS structural naming_](http://sixrevisions.com/css/css-tips/css-tip-2-structural-naming-convention-in-css/)  
[_Retrieve mutation position and ID given mutation in HGVS format_](https://www.biostars.org/p/107493/)  
[_What Is The Difference Between A Snp And An Entry In A Mutation Database?_](https://www.biostars.org/p/2812/)  
[_How does cBioPortal SQL database look like?_](https://github.com/cBioPortal/cbioportal/tree/master/core/src/main/resources/db)  
[_Baking Bootstrap Snippets with Jade_](Baking Bootstrap Snippets with Jade)  
[_What is Bootstrap and how do I use it?_](https://www.taniarascia.com/what-is-bootstrap-and-how-do-i-use-it/)
[_Normalizejs: A modern alternative to CSS reset_](https://github.com/necolas/normalize.css)   
[_Use app.locals to pass common data to all Jade templates_](http://stackoverflow.com/questions/23494839/layout-jade-navigation-bar)  
[_How to get disease-causing gene from OMIM_](https://www.biostars.org/p/118566/)  
[_How to set up nginx as reverse proxy on node application_](https://gist.github.com/joemccann/644282)  
[_Which Type Of Database Systems Are More Appropriate For Storing Information Extracted From Vcf Files_](https://www.biostars.org/p/65920/)  
[_Do people import VCF files into databases_](https://www.biostars.org/p/7372/)  
[_GATK: What is VCF and how should I interpret it_](http://gatkforums.broadinstitute.org/gatk/discussion/1268/what-is-a-vcf-and-how-should-i-interpret-it)
[_Database development mistakes made by application developers_](http://stackoverflow.com/questions/621884/database-development-mistakes-made-by-application-developers)  
[_How is javascript asynchronous and single-threaded_](http://www.sohamkamani.com/blog/2016/03/14/wrapping-your-head-around-async-programming/)  
[_The small tools manifesto for Bioinformatics_](https://github.com/pjotrp/bioinformatics)  
[_What are dbSNP rs accession number_](http://www.ncbi.nlm.nih.gov/SNP/get_html.cgi?whichHtml=how_to_submit#REFSNP)  
[_How to insert into multiple tables with foreign keys_](http://www.rndblog.com/insert-into-multiple-mysql-tables-linked-by-a-foreign-key/)  
[_What is the purpose of python with statement_](http://effbot.org/zone/python-with-statement.htm)  
[_How to create a python dictionary with list as defaults?_](http://stackoverflow.com/questions/28194184/how-do-i-create-a-dictionary-with-keys-from-a-list-and-values-separate-empty-lis)  
[_Useful nodejs and mysql tutorial on connection pooling_](http://stackoverflow.com/questions/6731214/node-mysql-connection-pooling)  
[_Good intro to RegExp_](http://www.w3schools.com/jsref/jsref_obj_regexp.asp)   
[_Is it possible to do client side scraping: NO > same origin policy_](http://stackoverflow.com/questions/9149672/is-there-any-javascript-and-client-side-wget-implementation)  
[_A nice article on ID conversion cross biological databases_](https://humgenomics.biomedcentral.com/articles/10.1186/1479-7364-5-6-703)   
[_a nice tutorial on how to use BioMart_](http://davetang.org/muse/2012/04/27/learning-to-use-biomart/)  
[_How to securely store mysql password locally_](http://dev.mysql.com/doc/refman/5.7/en/password-security-user.html)  
[_A good biostar post on genome assembly conversion_](https://www.biostars.org/p/65558/)   
[_Nice summary from UCSC on genome assembly versions_](http://genome.ucsc.edu/FAQ/FAQreleases.html)  
[_A working example of scrapy that inserts data to mysql in pipeline_](https://github.com/rolando/dirbot-mysql)  
[_A nice working example of bootstrap doc sidebar_](http://www.java2s.com/Tutorials/HTML_CSS/Bootstrap_Example/Nav/Create_Side_Navbar.htm)  
[_Uncaught error cannot read length of undefined d3js_](http://stackoverflow.com/questions/17181421/uncaught-typeerror-cannot-call-method-push-of-undefined-d3-force-layout)  
[_How to add swap space in ubuntu server_](https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-14-04)   
[_A biostar post on generating lolipop graph mapped to protein domains_](https://www.biostars.org/p/61049/)   
[_A nice gist on MakeFile_](https://gist.github.com/isaacs/62a2d1825d04437c6f08)   
[_pfam sql database schema_](http://pfam.xfam.org/help#tabview=tab11)   
[_How to use spider specific pipeline and item_](http://stackoverflow.com/questions/10543997/scrapy-how-to-change-spider-settings-after-start-crawling)    
[_Use scrapy itemloader in a loop_](http://stackoverflow.com/questions/37658950/using-scrapy-itemloader-in-a-loop)   
[_A good xpath cheatsheet_](http://ricostacruz.com/cheatsheets/xpath.html)   
[_d3 boxplot_](http://bl.ocks.org/mattbrehmer/12ea86353bc807df2187)    
[_comprehensive tutorial to webpack_](http://www.theodo.fr/blog/2016/07/a-comprehensive-introduction-to-webpack-the-module-bundler/)  
[_D3 radar graph_](http://bl.ocks.org/nbremer/6506614)  
