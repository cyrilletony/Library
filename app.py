from flask import *
import pymysql


app = Flask(__name__)

app.config['CON'] = pymysql.connect(host='localhost',
                             user='root',
                             password='',
                             database='library',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)


@app.route('/')
def index():
    con = app.config['CON']
    cursor = con.cursor()
    """Librarian = "CREATE TABLE IF NOT EXISTS Librarian (SSN INT AUTO_INCREMENT PRIMARY KEY,name VARCHAR(60),Phone_Number VARCHAR(15),\
    Designation VARCHAR(100))"

    Members = "CREATE TABLE IF NOT EXISTS Members (SSN INT AUTO_INCREMENT PRIMARY KEY, Campus_Addr VARCHAR(300),Phone_Number VARCHAR(15),\
    CardCreated_By_SSN INT, Card_Number INT, Name_On_Card VARCHAR(300), Date_Of_Issue DATE, Date_Of_Expiry DATE, Added_On DATE,\
    Added_By_SSN INT, FOREIGN KEY (CardCreated_By_SSN) references Librarian(SSN), FOREIGN Key (Added_By_SSN) references Librarian(SSN))"

    Book = "CREATE TABLE IF NOT EXISTS Book (ISBN int NOT NULL,Title varchar(50),Author varchar(50),Area_Of_Subject varchar(50),Added_By_SSN int,\
    Added_On date,PRIMARY KEY (ISBN),FOREIGN KEY (Added_By_SSN) references Librarian(SSN))"
    
    General_Member = "CREATE TABLE IF NOT EXISTS General_Member(Member_SSN int NOT NULL,House_Address varchar(300),\
    PRIMARY KEY (Member_SSN),FOREIGN KEY (Member_SSN) references Members(SSN))"

    Professor_Member = "CREATE TABLE IF NOT EXISTS Professor_Member(Member_SSN int NOT NULL,PRIMARY KEY (Member_SSN),\
    FOREIGN KEY (Member_SSN) references Members(SSN))"

    Within_Library = "CREATE TABLE IF NOT EXISTS Within_Library(Book_ISBN int NOT NULL,Book_Description varchar(1500),Binding varchar(250),\
    Edition int,PRIMARY KEY(Book_ISBN),FOREIGN KEY(Book_ISBN) references book(ISBN))"

    To_Acquire = "CREATE TABLE IF NOT EXISTS To_Acquire(Book_ISBN int NOT NULL,Reason varchar(500),\
    PRIMARY KEY(Book_ISBN),FOREIGN KEY(Book_ISBN) references book(ISBN))"

    Can_Lend = "CREATE TABLE IF NOT EXISTS Can_Lend(Book_ISBN int NOT NULL,Borrowed_Count int,Available_Count int,\
    PRIMARY KEY(Book_ISBN),FOREIGN KEY(Book_ISBN) references Within_Library(Book_ISBN))"

    Cannot_Lend = "CREATE TABLE IF NOT EXISTS Cannot_Lend(Book_ISBN int NOT NULL,Type varchar(250),Total_Count int,\
    PRIMARY KEY(Book_ISBN),FOREIGN KEY(Book_ISBN) references Within_Library(Book_ISBN))"

    Borrow = "CREATE TABLE IF NOT EXISTS Borrow(id int AUTO_INCREMENT PRIMARY KEY,Member_SSN int NOT NULL,Book_ISBN int NOT NULL,Issued_By_SSN int NOT NULL,\
    Issue_Date date NOT NULL,Grace_Period int,Date_Of_Returrn date,Returned_Or_Not varchar(20),Returned_By_SSN int,\
    FOREIGN KEY(Member_SSN) references Members(SSN),FOREIGN KEY(Book_ISBN) references Book(ISBN),\
    FOREIGN KEY(Issued_By_SSN) references Librarian(SSN),FOREIGN KEY(Returned_By_SSN) references Librarian(SSN))"

    Remark = "CREATE TABLE IF NOT EXISTS Remark(Member_SSN int NOT NULL,Issued_By_SSN int,Issue_Date date NOT NULL,Message varchar(400),\
    PRIMARY KEY(Member_SSN,Issue_Date),FOREIGN KEY(Member_SSN) references Members(SSN),FOREIGN KEY(Issued_By_SSN) references Librarian(SSN))"


    cursor.execute(Librarian)
    con.commit()
    cursor.execute(Members)
    con.commit()
    cursor.execute(Librarian)
    con.commit()
    cursor.execute(Book)
    con.commit()
    cursor.execute(General_Member)
    con.commit()
    cursor.execute(Professor_Member)
    con.commit()
    cursor.execute(Within_Library)
    con.commit()
    cursor.execute(To_Acquire)
    con.commit()
    cursor.execute(Can_Lend)
    con.commit()
    cursor.execute(Cannot_Lend)
    con.commit()
    cursor.execute(Borrow)
    con.commit()
    cursor.execute(Remark)
    con.commit()"""
    
    select = "SELECT * FROM Librarian"
    cursor.execute(select)
    result = cursor.fetchall()
    select = "SELECT * FROM Book left Join Librarian On Book.Added_By_SSN = Librarian.SSN"
    cursor.execute(select)
    book = cursor.fetchall()
    select = "SELECT *,B.name as name2 FROM Members inner Join Librarian as A On Members.CardCreated_By_SSN = A.SSN \
    inner join  Librarian as B On Members.Added_By_SSN = B.SSN"
    cursor.execute(select)
    members = cursor.fetchall()
    #print(members)
    return render_template("index.html", results = result, books = book, members = members)

@app.route('/addlibrarian')
def addlibrarian():
    return render_template("addstaff.html")

@app.route('/addstaff', methods = ["POST"])
def addstaff():
    con = app.config['CON']
    cursor = con.cursor()
    if request.method == "POST":
        name = request.form['name']
        phone = request.form['phone']
        designation = request.form['designation']
        query = "INSERT INTO Librarian(name, Phone_Number, Designation) VALUES (%s,%s,%s)"
        
        try:
            cursor.execute(query,(name,phone,designation))
            con.commit()
            return redirect("/")
        except :
            return redirect("/addlibrarian") 
@app.route('/addbook')
def addbook():
    return render_template("addbook.html")
@app.route('/addbooks', methods=["POST"])
def addbooks():
    con = app.config['CON']
    cursor = con.cursor()
    if request.method == "POST":
        ISBN = request.form['ISBN']
        Title = request.form['title']
        Author = request.form['author']
        Area_Of_Subject = request.form['area_of_subject']
        Added_On = request.form['added_on']
        query = "INSERT INTO Book(ISBN, Title, Author,Area_Of_Subject,Added_By_SSN,Added_On) VALUES (%s,%s,%s,%s,%s,%s)"
        
        try:
            cursor.execute(query,(ISBN,Title,Author,Area_Of_Subject,1,Added_On))
            con.commit()
            return redirect("/")
        except :
            return redirect("/addbook") 
    return render_template("addbook.html")

@app.route('/addmember')
def addmember():
    return render_template("addmember.html")
@app.route('/addmember2', methods=["POST"])
def addmember2():
    con = app.config['CON']
    cursor = con.cursor()
    if request.method == "POST":
        campus_address = request.form['address']
        phone = request.form['phone']
        card_number = request.form['card_no']
        name = request.form['name']
        dateofissue = request.form['date_issue']
        expirydate = request.form['date_expiry']
        addedon = request.form['added_on']
        query = "INSERT INTO Members(Campus_Addr,Phone_Number,CardCreated_By_SSN, Card_Number, Name_On_Card, Date_Of_Issue,\
         Date_Of_Expiry, Added_On,Added_By_SSN) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        
        try:
            cursor.execute(query,(campus_address,phone,2,card_number,name,dateofissue,expirydate,addedon,3))
            con.commit()
            return redirect("/")
        except :
            return redirect("/addmember")
@app.route('/bookcheckout')
def bookcheckout():
    con = app.config['CON']
    cursor = con.cursor()
    select = "SELECT DISTINCT *, COUNT(Book_ISBN) as count, WEEK(Borrow.Issue_Date) as weekn FROM Borrow inner join Librarian on Librarian.SSN = Borrow.Issued_By_SSN inner join \
    Members on Members.SSN = Borrow.Member_SSN group by WEEK(Borrow.Issue_Date)"

    cursor.execute(select)
    members = cursor.fetchall()
    #print(members)
    return render_template('bookcheckout.html',members = members)

@app.route('/searchbook',methods=["POST"])
def searchbook():
    con = app.config['CON']
    cursor = con.cursor()
    if request.method == "POST":
        book = request.form['book']
        if book == "":
            result = False
        else:
            select = "SELECT * FROM Book WHERE (ISBN LIKE '%"+book+"%') OR (Title LIKE '%"+book+"%') OR (Author LIKE '%"+book+"%')"
            cursor.execute(select)
            result = cursor.fetchall()
            if result == "":
                result = ""
            else:
                result = result
    return render_template('bookcheckout.html', results = result)
@app.route('/bookthis',methods=["POST"])
def bookthis():
    con = app.config['CON']
    cursor = con.cursor()
    if request.method == "POST":
        ISBN = request.form['ISBN']
        return render_template("bookbook.html",ISNB = ISBN)
@app.route('/bookabook',methods=["POST"])
def bookabook():
    con = app.config['CON']
    cursor = con.cursor()
    if request.method == "POST":
        try:
            
            ISBN = request.form["ISBN"]
            ssn = request.form["ssn"]
            issuedate = request.form['issuedate']
            grace = request.form['grace']
            returndate = request.form['returndate']
            returned = request.form['tof']
            #print(ssn)
            query2 = "INSERT INTO borrow (id,Member_SSN,Book_ISBN,Issued_By_SSN,Issue_Date, \
            Grace_Period,Date_Of_Returrn,Returned_Or_Not,Returned_By_SSN) \
            VALUES (NULL, "+ssn+", "+ISBN+", 3, '"+issuedate+"', "+grace+", '"+returndate+"', "+returned+", 1)"
            print(query2)
            cursor.execute(query2)
            con.commit()
            return redirect("/bookcheckout")
        except :
            print("Nothing executed!!")
            return redirect("/bookcheckout")
@app.route('/renewal/<int:ssn>')
def renewal(ssn):
    con = app.config['CON']
    cursor = con.cursor()
    select = "SELECT * FROM Members where SSN ={}".format(ssn)
    cursor.execute(select)
    result = cursor.fetchone()
    return render_template('renewal.html', results = result)
@app.route('/renewdate', methods=['POST'])
def renewdate():
    con = app.config['CON']
    cursor = con.cursor()
    if request.method == "POST":
        try:
            ssn = request.form['ssn']
            newdate = request.form['new']

            requery = "UPDATE Members set Date_Of_Expiry = '{}' where SSN = {}".format(newdate,ssn)
            print(requery)
            cursor.execute(requery)
            con.commit()
            return redirect("/")
        except Exception as e:
            return redirect('/')
@app.route('/visits')
def visits():
    con = app.config['CON']
    cursor = con.cursor()
    select = "SELECT * FROM Borrow inner join Librarian on Librarian.SSN = Borrow.Issued_By_SSN inner join \
    Members on Members.SSN = Member_SSN"

    cursor.execute(select)
    visits = cursor.fetchall()
    return render_template("visits.html",visits = visits)
@app.route('/trigger1')
def trigger1():
    con = app.config['CON']
    cursor = con.cursor()
    query3 = "CREATE TRIGGER outstanding BEFORE INSERT ON Borrow FOR EACH ROW BEGIN IF (select COUNT(*) from borrow)\
     = 0 THEN SET borrow.Returned_Or_Not = 'False' END IF END"
    cursor.execute(query3)
    trigger = cursor.fetchall()
    return render_template("index.html",trigger = trigger)
@app.route('/trigger2')
def trigger2():
    con = app.config['CON']
    cursor = con.cursor()
    query4 = "CREATE TRIGGER renewal BEFORE INSERT ON Members FOR EACH ROW BEGIN IF (select Members.Date_Of_Expiry from Members)\
     = NOW() THEN SET Remark.message = 'Membership renewal due!'; END IF; END"
    cursor.execute(query4)
    trigger2 = cursor.fetchall()
    return render_template("index.html",trigger = trigger2)
@app.route('/checkin')
def checkin():
    return render_template('checkin.html')

@app.route('/checkinbook', methods=['POST'])
def checkinbook():
    con = app.config['CON']
    cursor = con.cursor()
    if request.method == "POST":
        try:
            isnb = request.form['ISBN']
            ssn = request.form['ssn']
            remark = request.form['remark']
            lssn = request.form['libssn']
            cquery = "SELECT * Members.name as name FROM Borrow \
            inner join Members on Members.SSN =Borrow.SSN where Member_SSN = {}".format(ssn)
            cursor.execute(cquery)
            check = cursor.fetchone()
            print('Book No.:'+isnb)
            print('Member Name:'+check.name)
            return redirect('/')
        except:
            return redirect('/')

if __name__ == '__main__':
	app.run(host='localhost', port=5000)