bank :
INSERT INTO Bank VALUES ('BK01', 'HDFC Bank', 'MG Road');
INSERT INTO Bank VALUES ('BK02', 'SBI Bank', 'Surathkal');
INSERT INTO Bank VALUES ('BK03', 'ICICI Bank', 'Kankanady');
INSERT INTO Bank VALUES ('BK04', 'Axis Bank', 'Udupi');
INSERT INTO Bank VALUES ('BK05', 'Canara Bank', 'Mangalore');
branch : 
INSERT INTO Branch VALUES ('BR01', 'MG Road Branch', 'MG Road', 'BK01');
INSERT INTO Branch VALUES ('BR02', 'Surathkal Branch', 'Surathkal', 'BK02');
INSERT INTO Branch VALUES ('BR03', 'Kankanady Branch', 'Kankanady', 'BK03');
INSERT INTO Branch VALUES ('BR04', 'Udupi Branch', 'Udupi', 'BK04');
INSERT INTO Branch VALUES ('BR05', 'Mangalore Branch', 'Mangalore', 'BK05');
customer:
INSERT INTO Customer VALUES (101, 'Ravi', '9876543210', 'Bangalore');
INSERT INTO Customer VALUES (102, 'Arjun', '8765432109', 'Mangalore');
INSERT INTO Customer VALUES (103, 'Rahul', '7654321098', 'Surathkal');
INSERT INTO Customer VALUES (104, 'Anjali', '6543210987', 'Udupi');
INSERT INTO Customer VALUES (105, 'Priya', '5432109876', 'Kankanady');
account:
INSERT INTO Account VALUES (1001, 'Savings', 15000, 'BR01');
INSERT INTO Account VALUES (1002, 'Current', 2000, 'BR02');
INSERT INTO Account VALUES (1003, 'Savings', 500, 'BR03');
INSERT INTO Account VALUES (1004, 'Current', 25000, 'BR04');
INSERT INTO Account VALUES (1005, 'Savings', 8000, 'BR05');
customer_account:
INSERT INTO Customer_Account VALUES (101, 1001);
INSERT INTO Customer_Account VALUES (102, 1002);
INSERT INTO Customer_Account VALUES (103, 1003);
INSERT INTO Customer_Account VALUES (104, 1004);
INSERT INTO Customer_Account VALUES (105, 1005);
loan:
INSERT INTO Loan VALUES (2001, 'Home Loan', 500000, 'BR01');
INSERT INTO Loan VALUES (2002, 'Vehicle Loan', 300000, 'BR02');
INSERT INTO Loan VALUES (2003, 'Home Loan', 700000, 'BR03');
INSERT INTO Loan VALUES (2004, 'Personal Loan', 100000, 'BR04');
INSERT INTO Loan VALUES (2005, 'Vehicle Loan', 250000, 'BR05');
customer_loan
INSERT INTO Loan VALUES (2001, 'Home Loan', 500000, 'BR01');
INSERT INTO Loan VALUES (2002, 'Vehicle Loan', 300000, 'BR02');
INSERT INTO Loan VALUES (2003, 'Home Loan', 700000, 'BR03');
INSERT INTO Loan VALUES (2004, 'Personal Loan', 100000, 'BR04');
INSERT INTO Loan VALUES (2005, 'Vehicle Loan', 250000, 'BR05');
