import MySQLdb
import csv
from collections import defaultdict
from Config import DB_HOST, DB_USER, DB_PASS, DB_NAME


class LoadData:
    """
    loading data from excel to mysql using mysqldb
    """

    def __init__(self):
        """
        initiate data loading from excel
        """
        self.db = MySQLdb.connect(DB_HOST, DB_USER, DB_PASS, DB_NAME)
        # A Cursor object execute queries
        self.c = self.db.cursor()
        self.data = defaultdict(list)


    def importCSV(self, excelPath):
        """
        import CSV file and store columns as dict[list[tuple]] in self.data
        """
        header = []
        with open(excelPath, 'r') as csvfile:
            data = csv.reader(csvfile)
            for index,row in enumerate(data):
                if index == 0:  # first row
                    header = row
                else:            # other rows
                    for i,v in enumerate(header):
                        self.data[v].append(row[i])
    def deleteAllEntries(self):
        try:
            self.c.execute("""DELETE FROM Gene;
                            DELETE FROM Transcript;
                            DELETE FROM Variant;
                            DELETE FROM Disease;
                            DELETE FROM ORFeome;
                            DELETE FROM VariantProperty;
                            DELETE FROM HGMDMapping;
                            DELETE FROM LocalCollection;
                            DELETE FROM Measurement;
                            DELETE FROM SummaryStatistics;""")
            self.db.commit()
        except:
            print 'delete all entry from all tables failed'
            self.db.rollback()


    def subsetCols(self, colList):
        """
        subset the columns of imported csv data

        @param colList list: list containing column name specified in header
        @return list(tuple): returns a unique subset of table
        """
        sort = [int(v) - 1 for v in self.data["Sort"]]
        subset =  [tuple([self.data[colname][i] for colname in colList]) for i in sort]
        return list(set(subset))


    def loadTables(self):
        """
        master function which controls individual insertion
        """
        self.deleteAllEntries()
        self.loadGeneTable()
        self.loadTranscriptTable()
        self.db.close()

    def loadGeneTable(self):
        inserts = self.subsetCols(['Entrez_Gene_ID', 'Symbol'])
        print inserts
        try:
            sql = """INSERT INTO Gene (ENTREZ_GENE_ID, HUGO_GENE_SYMBOL)
                    VALUES (%s, %s)"""
            self.c.executemany(sql, inserts)
            self.db.commit()
        except:
            print 'insert to gene table failed'
            self.db.rollback()


    def loadTranscriptTable(self):
        subset = self.subsetCols(['Mutation_RefSeq_NT', 'Entrez_Gene_ID'])
        inserts = [(t[0].split(':')[0], t[1]) for t in subset]
        try:
            sql = """INSERT INTO Transcript (REFSEQ_ID, ENTREZ_GENE_ID)
                    VALUES (%s, %s)"""
            self.c.executemany(sql, inserts)
            self.db.commit()
        except:
            print 'insert to transcript table failed'
            self.db.rollback()


if __name__ == "__main__":
    ld = LoadData()
    ld.importCSV("./origExcel/csvMutCollection.csv")
    ld.loadTables()
