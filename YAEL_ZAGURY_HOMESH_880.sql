SET NOCOUNT ON
GO

USE master
GO
if exists (select * from sysdatabases where name='HOMESH_880')
		drop database [HOMESH_880]
go

/****** Object:  Database [HOMESH_880]    Script Date: 23/11/2024 22:22:44 ******/
CREATE DATABASE [HOMESH_880]
 CONTAINMENT = NONE
 ON  PRIMARY
( NAME = N'HOMESH_880', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\HOMESH_880.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HOMESH_880_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\HOMESH_880_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HOMESH_880].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [HOMESH_880] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [HOMESH_880] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [HOMESH_880] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [HOMESH_880] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [HOMESH_880] SET ARITHABORT OFF 
GO

ALTER DATABASE [HOMESH_880] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [HOMESH_880] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [HOMESH_880] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [HOMESH_880] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [HOMESH_880] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [HOMESH_880] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [HOMESH_880] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [HOMESH_880] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [HOMESH_880] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [HOMESH_880] SET  DISABLE_BROKER 
GO

ALTER DATABASE [HOMESH_880] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [HOMESH_880] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [HOMESH_880] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [HOMESH_880] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [HOMESH_880] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [HOMESH_880] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [HOMESH_880] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [HOMESH_880] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [HOMESH_880] SET  MULTI_USER 
GO

ALTER DATABASE [HOMESH_880] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [HOMESH_880] SET DB_CHAINING OFF 
GO

ALTER DATABASE [HOMESH_880] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [HOMESH_880] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [HOMESH_880] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [HOMESH_880] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [HOMESH_880] SET QUERY_STORE = ON
GO

ALTER DATABASE [HOMESH_880] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO

ALTER DATABASE [HOMESH_880] SET  READ_WRITE 
GO


USE HOMESH_880
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/****** Object:  Table  [Targets]    */

CREATE TABLE [Targets](
	[Target] [nvarchar](100) NOT NULL,
	[Short_Target] [nvarchar](30) NOT NULL, --PK

	CONSTRAINT [PK_Targets] PRIMARY KEY  CLUSTERED 
	(
		[Short_Target]
	)
 )
 GO


 /****** Object:  Table [Lavy_Codes]    */
 
CREATE TABLE [Lavy_Codes](
	[ID_Lavy] int NOT NULL, --PK
	[Lavy_Project_Name] [nvarchar](30) NOT NULL,
	[Code_Discription] [nvarchar](150) NOT NULL,
	[Dpartment] [nvarchar](10) NULL,
	[Target_In_The_Program] [nvarchar](30) NOT NULL, --FK

	CONSTRAINT [PK_Lavy_Codes] PRIMARY KEY  CLUSTERED 
	(
		[ID_Lavy]
	),
	CONSTRAINT [FK_Target_In_The_Program] FOREIGN KEY 
	(
		[Target_In_The_Program]
	) REFERENCES [dbo].[Targets] (
		[Short_Target]
	)
 )
  GO
 

/****** Object:  Table  [Projects]    */
USE HOMESH_880
GO
 CREATE TABLE [Projects](
	[Project_ID] int IDENTITY (1, 1) NOT NULL, --PK
	[Target] [nvarchar](30) NOT NULL, --FK
	[Study_Year] [nvarchar](5) NOT NULL,
	[Project_Name] [nvarchar](40) NOT NULL,
	[Annual_Cost] [money] NULL CONSTRAINT [DF_Product_Annual_Cost] DEFAULT (0),
	[Budgeted_By_MOEd] [money] NULL CONSTRAINT [DF_Budgeted_By_MOEd] DEFAULT (0),

	CONSTRAINT [PK_Projects] PRIMARY KEY  CLUSTERED 
	(
		[Project_ID]
	),
	CONSTRAINT [FK_Product_Target] FOREIGN KEY 
	(
		[Target]
	) REFERENCES [dbo].[Targets] (
		[Short_Target]
	),
	CONSTRAINT [CK_Study_Year] CHECK ([Study_Year] in ('���"�' , '���"�' , '���"�' , '���"�' , '���"�')
)
 )
 GO


/****** Object:  Table [Suppliers]    */

CREATE TABLE [Suppliers](
	[Supplier_ID] int NOT NULL, --PK
	[Supplier_Name] [nvarchar](40) NOT NULL, 
	
	CONSTRAINT [PK_Supplier_ID] PRIMARY KEY  CLUSTERED 
	(
		[Supplier_ID]
	)
 )
  GO


 /****** Object:  Table [Work_Orders]    */

CREATE TABLE [Work_Orders](
	[Order_Date] DATE NOT NULL,		
	[Study_Year] [nvarchar](5) NOT NULL, 
	[Contract_Num] [nvarchar](10) NULL, 
	[Contract_Budget] money NULL,
	[Oreder_ID] [nvarchar](10) NOT NULL, --PK
	[Order_Description] [nvarchar](40) NOT NULL,
	[Supplier_ID] int NOT NULL, --FK
	[Budget_Section] int NOT NULL,
	[Budget_Subsection] int NULL,
	[Order_Cost] money NOT NULL,
	[Order_Status] [nvarchar](40) NULL,
	[Comments] [nvarchar](150) NULL,

	CONSTRAINT [PK_Oreder_ID] PRIMARY KEY  CLUSTERED 
	(
		[Oreder_ID]
	),
	CONSTRAINT [FK_Supplier_Name] FOREIGN KEY 
	(
		[Supplier_ID]
	) REFERENCES [dbo].[Suppliers] (
		[Supplier_ID]
	),
	CONSTRAINT [CK_Order_Study_Year] CHECK ([Study_Year] in ('���"�' , '���"�' , '���"�' , '���"�' , '���"�') )
  )
GO


 /****** Object:  Table [Invoices]    */


CREATE TABLE [Invoices](
	[Invoice_ID] int IDENTITY (1, 1) NOT NULL,	--PK	
	[Pay_Channel] nvarchar(6) NOT NULL,
	[Oreder_ID] nvarchar(10) NULL, --FK
	[Payment_Request] nvarchar(22) NULL CONSTRAINT [DF_Payment_Request] DEFAULT (0),
	[Received_Date] date NOT NULL,
	[Supplier_Invoice_Doc] nvarchar(20) NOT NULL,
	[ID_Lavy] int NULL,
	[Target] nvarchar(30) NOT NULL, --FK
	[Project_ID] int NULL, --FK
	[Sub_Project_Name] nvarchar(45) NOT NULL,
	[Supplier_Name] nvarchar(40) NOT NULL,
	[Description] nvarchar(200) NOT NULL,
	[Received_From] nvarchar(25) NOT NULL,
	[Salaries_Or_Activity] nvarchar(6) NOT NULL,
	[Price_Before_Overhead] money NOT NULL,
	[Price_Includes_Overhead] money NOT NULL,
	[To_Report] money NOT NULL,
	[Status] nvarchar(25) NULL,
	[Status_Update_Date] date NULL CONSTRAINT [DF_Status_Update_Date] DEFAULT (GETDATE ()),
	[Note_For_Reporting] nvarchar(100) NULL,
	[For_Reporting] nvarchar(15) NULL,
	[Was_Reported] nvarchar(2) NULL,
	[Report_date] date NULL,
	[Calendar Year] int NOT NULL,
	[Study_Year] nvarchar(5) NOT NULL,
	[Invoice_Month] nvarchar(7) NOT NULL,

	CONSTRAINT [PK_Invoice_ID] PRIMARY KEY  CLUSTERED 
	(
		[Invoice_ID]
	),
	CONSTRAINT [CK_Pay_Channel] CHECK ([Pay_Channel] IN ('����' , '������')
	),
	CONSTRAINT [FK_Oreder_ID] FOREIGN KEY 
	(
		[Oreder_ID]
	) REFERENCES [dbo].[Work_Orders] (
		[Oreder_ID]
	),
	CONSTRAINT [FK_Invoice_ID_Lavy] FOREIGN KEY 
	(
		[ID_Lavy]
	) REFERENCES [dbo].[Lavy_Codes] (
		[ID_Lavy]
	),
	CONSTRAINT [FK_Invoice_Target] FOREIGN KEY 
	(
		[Target]
	) REFERENCES [dbo].[Targets] (
		[Short_Target]
	),
	CONSTRAINT [FK_Invoice_Project_ID] FOREIGN KEY 
	(
		[Project_ID]
	) REFERENCES [dbo].[Projects] (
		[Project_ID]
	),
	CONSTRAINT [CK_Salaries_Or_Activity] CHECK ([Salaries_Or_Activity] in ('���' , '������')
	),
	CONSTRAINT [CK_Invoice_Status] CHECK ([Status] in ('���� �����' , '���� ����� ����' , '����' , '�����' , '���� ������ �����' , '�������' ,
													   '��� ����"�' , '����' , '������- ������' , '�����' , '����� ������ �����' , '�� ����� ������ �����')
	),
	CONSTRAINT [CK_For_Reporting] CHECK ([For_Reporting] in ('��' , '���� ������' , '���� �������' , '��� �������' , '�.�.�' , '����-���')
	),
	CONSTRAINT [CK_Was_Reported] CHECK ([Was_Reported] in ('��' , '��')
	),
	CONSTRAINT [CK_Invoice_Study_Year] CHECK ([Study_Year] in ('���"�' , '���"�' , '���"�' , '���"�' , '���"�')
 )
)
GO


 /****** Object:  VIEW [VW_Projects_Summary]    */

 CREATE VIEW VW_Projects_Summary AS
 WITH A
 AS
 (SELECT DISTINCT
       I.Project_ID
	  ,SUM(I.Price_Includes_Overhead) OVER (PARTITION BY I.Project_ID) AS Used_budget
  FROM [dbo].[Invoices] I
  WHERE I.Study_Year = '���"�'),
 B AS
 (SELECT DISTINCT
       I.Project_ID
	  ,SUM (I.To_Report) OVER (PARTITION BY I.Project_ID) AS Reported
  FROM [dbo].[Invoices] I
  WHERE 1=1
        AND I.For_Reporting = '���� ������'
		AND I.Was_Reported = '��'
		AND I.Study_Year = '���"�'),
C AS
 (SELECT DISTINCT
       I.Project_ID
	  ,SUM (I.To_Report) OVER (PARTITION BY I.Project_ID) AS Not_Reported
  FROM [dbo].[Invoices] I
  WHERE 1=1
        AND I.For_Reporting = '���� ������'
		AND I.Was_Reported = '��'
		AND I.Study_Year = '���"�')
 SELECT P.Project_ID
       ,Target
       ,[Study_Year]
       ,[Project_Name]
       ,FORMAT ([Annual_Cost],'#,#.0') AS Annual_Cost
	   ,FORMAT (A.Used_budget, '#,#.0') AS Used_budget
	   ,FORMAT (P.Annual_Cost - A.Used_budget , '#,#.0') AS Budget_Balance
       ,FORMAT ([Budgeted_By_MOEd], '#,#.0') AS Budgeted_By_MOEd
	   ,FORMAT (P.Annual_Cost -Budgeted_By_MOEd, '#,#.0') AS Not_Budgeted
	   ,FORMAT (B.Reported,'#,#.0') AS Reported
	   ,FORMAT (A.Used_budget - B.Reported,'#,#.0') AS Balance_To_Report
 FROM [dbo].[Projects] P LEFT JOIN A
 ON P.Project_ID = A.Project_ID
 LEFT JOIN B
 ON P.Project_ID = B.Project_ID
 LEFT JOIN C
 ON P.Project_ID = C.Project_ID
GO

 /****** Object:  VIEW [VW_Work_Orders]    */

 CREATE VIEW VW_Work_Orders AS
 WITH A
 AS
 (SELECT DISTINCT
       I.Oreder_ID
	  ,SUM(I.Price_Includes_Overhead) OVER (PARTITION BY I.Oreder_ID) AS Used_budget
  FROM [dbo].[Invoices] I)
 SELECT W.Order_Date
       ,W.Study_Year
	   ,W.Contract_Num
	   ,W.Contract_Budget
	   ,W.Oreder_ID
	   ,W.Order_Description
	   ,S.Supplier_Name
	   ,W.Supplier_ID
	   ,W.Budget_Section
	   ,W.Budget_Subsection
	   ,FORMAT (W.Order_Cost,'#,#.0') AS Order_Cost
	   ,FORMAT (A.Used_budget,'#,#.0') AS Used_budget
	   ,FORMAT (W.Order_Cost - A.Used_budget,'#,#.0') AS Budget_Balance
	   ,W.Order_Status
	   ,W.Comments
 FROM [dbo].[Work_Orders] W JOIN A
 ON W.Oreder_ID = A.Oreder_ID
 JOIN Suppliers S
 ON S.Supplier_ID = W.Supplier_ID
 GO

 /****** INSERT VALUES TO :  Table [Targets]    */
INSERT [Targets] ([Target],[Short_Target]) VALUES ('����� �����' , '����� �����' )
INSERT [Targets] ([Target],[Short_Target]) VALUES ('����� ������ �������� ����� �������' , '����� �������' )
INSERT [Targets] ([Target],[Short_Target]) VALUES ('����� ��������� ������ ������ ' , '����� ���� ��' )
INSERT [Targets] ([Target],[Short_Target]) VALUES ('����� ������ ����� �������� ' , '����� ���� ��������' )
INSERT [Targets] ([Target],[Short_Target]) VALUES ('����� �����, ����� ����� ������ �����, ����� ������ ������ ����' , '����� ���� ������ �����' )
INSERT [Targets] ([Target],[Short_Target]) VALUES ('����� ������ ����� ������ ���� ������' , '���� ������' )
GO

 /****** INSERT VALUES TO :  Table [Lavy_Codes]    */

INSERT [Lavy_Codes] ([ID_Lavy],[Lavy_Project_Name],[Code_Discription],[Dpartment],[Target_In_The_Program]) VALUES ('790' , '����� ����� ����' , '���� �����, ��������' , '���"�' , '����� �����')
INSERT [Lavy_Codes] ([ID_Lavy],[Lavy_Project_Name],[Code_Discription],[Dpartment],[Target_In_The_Program]) VALUES ('791' , '������� ����' , '�����, ����� ������ ������ ������� ���� ������. ����� ���� ������' , '���"�' , '����� ���� ��')
INSERT [Lavy_Codes] ([ID_Lavy],[Lavy_Project_Name],[Code_Discription],[Dpartment],[Target_In_The_Program]) VALUES ('792' , '����� ���� ����' , '������ ��������,����� ��"�, ������ ����� ����������� ���� ����� �������. �������, ������ ����� �����' , '���"� ' , '����� ���� ������ �����')
INSERT [Lavy_Codes] ([ID_Lavy],[Lavy_Project_Name],[Code_Discription],[Dpartment],[Target_In_The_Program]) VALUES ('793' , '�������� �������' , '������� ��������' , '���"�' , '����� ���� ��������')
INSERT [Lavy_Codes] ([ID_Lavy],[Lavy_Project_Name],[Code_Discription],[Dpartment],[Target_In_The_Program]) VALUES ('794' , '����� ������� ����' , '��� ��� ������, ������������' , '���"�' , '���� ������')
INSERT [Lavy_Codes] ([ID_Lavy],[Lavy_Project_Name],[Code_Discription],[Dpartment],[Target_In_The_Program]) VALUES ('795' , '����� �������� ����' , '������ ���������, ����� ����������, ������, ����� ������� ����������. ������� �������, ���� ��������, ���� �������' , '���"�' , '����� ���� ��������')
INSERT [Lavy_Codes] ([ID_Lavy],[Lavy_Project_Name],[Code_Discription],[Dpartment],[Target_In_The_Program]) VALUES ('787' , '����� �������' , '����� ������ ������ ������ �����, ����� ����� ��������, ����� ������, ���� ����� ������ �������' , '���"�' , '����� �������')
INSERT [Lavy_Codes] ([ID_Lavy],[Lavy_Project_Name],[Code_Discription],[Dpartment],[Target_In_The_Program]) VALUES ('961' , '�����' , '������ ����� ���� ����' , '����' , '���� ������')
INSERT [Lavy_Codes] ([ID_Lavy],[Lavy_Project_Name],[Code_Discription],[Dpartment],[Target_In_The_Program]) VALUES ('963' , '�����' , '����� ���� ������+������' , '����' , '���� ������')
INSERT [Lavy_Codes] ([ID_Lavy],[Lavy_Project_Name],[Code_Discription],[Dpartment],[Target_In_The_Program]) VALUES ('966' , '����� ����������' , '������ ����� ���� ����' , '����' , '���� ������')
GO

 /****** INSERT VALUES TO :  Table [Projects]    */

INSERT [Projects] VALUES('����� �����' , '���"�' , '����� �����' , '2292000' , '0')
INSERT [Projects] VALUES('����� �������' , '���"�' , '����� 2.0 - ����� ��� �����' , '292500' , '292500')
INSERT [Projects] VALUES('����� �������' , '���"�' , '����� ������' , '2349999.99' , '2349999.99')
INSERT [Projects] VALUES('����� �������' , '���"�' , '����� ������ ������ ������� ' , '500000' , '500000')
INSERT [Projects] VALUES('����� �������' , '���"�' , '������� ������ ������ ����������' , '1500000' , '1500000')
INSERT [Projects] VALUES('����� �������' , '���"�' , '����� ����� ������� ��������' , '400000' , '400000')
INSERT [Projects] VALUES('����� �������' , '���"�' , '���� �����' , '7000000' , '7000000')
INSERT [Projects] VALUES('����� �������' , '���"�' , '������ �����' , '12000000' , '12000000')
INSERT [Projects] VALUES('����� �������' , '���"�' , '����� ������ ����' , '12000000' , '12000000')
INSERT [Projects] VALUES('����� ���� ��' , '���"�' , '����� ����� ������� ��������' , '487600' , '487600')
INSERT [Projects] VALUES('����� ���� ��' , '���"�' , '����' , '750000' , '750000')
INSERT [Projects] VALUES('����� ���� ��' , '���"�' , '������� ���� ���� ��������' , '2000000' , '2000000')
INSERT [Projects] VALUES('����� ���� ��' , '���"�' , '���� �- ITEST (����� 014386)' , '208000' , '208000')
INSERT [Projects] VALUES('����� ���� ��' , '���"�' , '����� ������' , '1900000' , '1900000')
INSERT [Projects] VALUES('����� ���� ��' , '���"�' , '��� ����� ����� �� ������' , '200000' , '200000')
INSERT [Projects] VALUES('����� ���� ��' , '���"�' , '���� ����� ���������� ' , '200000' , '200000')
INSERT [Projects] VALUES('����� ���� ��' , '���"�' , '���� ���� ' , '700000' , '700000')
INSERT [Projects] VALUES('����� ���� ��' , '���"�' , '����� �������� ������ ������' , '1260000' , '1260000')
INSERT [Projects] VALUES('����� ���� ��������' , '���"�' , ' ������ ������� ' , '306600' , '306600')
INSERT [Projects] VALUES('����� ���� ��������' , '���"�' , ' ������ ������ ' , '150000' , '150000')
INSERT [Projects] VALUES('����� ���� ��������' , '���"�' , ' ����� ������ ���������� ������  ' , '300000' , '300000')
INSERT [Projects] VALUES('����� ���� ��������' , '���"�' , '����� ������� (���������)' , '1500000' , '1500000')
INSERT [Projects] VALUES('����� ���� ��������' , '���"�' , '����� ��� �����' , '20000' , '20000')
INSERT [Projects] VALUES('����� ���� ��������' , '���"�' , '��������' , '1000000' , '1000000')
INSERT [Projects] VALUES('����� ���� ��������' , '���"�' , '�������' , '2000000' , '2000000')
INSERT [Projects] VALUES('����� ���� ��������' , '���"�' , '������ ����������' , '2500000' , '2500000')
INSERT [Projects] VALUES('����� ���� ������ �����' , '���"�' , '��"� - ���� �����' , '480000' , '480000')
INSERT [Projects] VALUES('����� ���� ������ �����' , '���"�' , '��"� - ���������� �����' , '630000' , '630000')
INSERT [Projects] VALUES('����� ���� ������ �����' , '���"�' , '����� ���"� (��"� ��"�)' , '12000000' , '8000000')
INSERT [Projects] VALUES('����� ���� ������ �����' , '���"�' , '������ ����� �����' , '1126400' , '1126400')
INSERT [Projects] VALUES('���� ������' , '���"�' , '��� ���� ����� ' , '999999.999' , '999999.999')
INSERT [Projects] VALUES('���� ������' , '���"�' , '����� ������ - �-� ��� ���"�' , '700000' , '700000')
INSERT [Projects] VALUES('���� ������' , '���"�' , '��� ��� ������ ' , '1000000' , '1000000')
INSERT [Projects] VALUES('���� ������' , '���"�' , '�����: ����� �-��' , '4000000' , '4000000')
INSERT [Projects] VALUES('���� ������' , '���"�' , '����� (����)' , '40000' , '40000')
INSERT [Projects] VALUES('���� ������' , '���"�' , '��"� ���� - ���� �����' , '1500000' , '1500000')
INSERT [Projects] VALUES('���� ������' , '���"�' , '����� ����' , '4800000' , '4800000')
INSERT [Projects] VALUES('���� ������' , '���"�' , ' ������������' , '1500000' , '1000000')
GO

 /****** INSERT VALUES TO :  Table [Suppliers]    */

INSERT [Suppliers] VALUES(101 , '��� ���� ��"�')
INSERT [Suppliers] VALUES(102 , '���������� ������')
INSERT [Suppliers] VALUES(103 , '������� ��������� �����')
INSERT [Suppliers] VALUES(104 , '�������� �����')
INSERT [Suppliers] VALUES(105 , '��� �������� ��������')
INSERT [Suppliers] VALUES(106 , '����� ������')
INSERT [Suppliers] VALUES(107 , '����� ���� �����')
INSERT [Suppliers] VALUES(108 , '�������� �������� ��"�')
INSERT [Suppliers] VALUES(109 , '������ ���� ��"�')
INSERT [Suppliers] VALUES(110 , '���� ����� �������')
INSERT [Suppliers] VALUES(111 , '����� ����')
INSERT [Suppliers] VALUES(112 , '���� �����')
INSERT [Suppliers] VALUES(113 , '��������� ��� ��"�')
INSERT [Suppliers] VALUES(114 , '������ ������� ��"�')
INSERT [Suppliers] VALUES(115 , '������ �������')
INSERT [Suppliers] VALUES(116 , '��� ����� ���� �������')
INSERT [Suppliers] VALUES(117 , '���� ����� �����')
INSERT [Suppliers] VALUES(118 , '����� ����� �������')
INSERT [Suppliers] VALUES(119 , '�������� ���� ����� ��"�')
GO

 /****** INSERT VALUES TO :  Table [Work_Orders]    */

INSERT [Work_Orders] VALUES('09/01/2023','���"�',NULL,NULL,'36-23-366','���� ���"�',111,81679555,NULL,3000000,'����',NULL)
INSERT [Work_Orders] VALUES('10/25/2023','���"�',NULL,NULL,'36-23-325','���� ���"�',111,81679555,NULL,3000000,'����',NULL)
INSERT [Work_Orders] VALUES('12/18/2023','���"�','36-23-0003',294000,'36-23-403','����� �����',101,81679555,NULL,294000,'����',NULL)
INSERT [Work_Orders] VALUES('12/19/2023','���"�','36-23-0004',210800,'36-23-405','����� �����',101,81679555,NULL,210800,'����',NULL)
INSERT [Work_Orders] VALUES('12/24/2023','���"�',NULL,9000000,'36-23-408','���� ���� �������',111,81679555,NULL,9000000,'����',NULL)
INSERT [Work_Orders] VALUES('01/01/2024','���"�','36-24-0001',89400,'36-24-0001','����� ��������',119,81679555,NULL,89400,'����',NULL)
INSERT [Work_Orders] VALUES('01/16/2024','���"�','36-24-0003',326400,'36-24-0004','����� ����� �����',115,81679555,NULL,326400,'���� ',NULL)
INSERT [Work_Orders] VALUES('01/16/2024','���"�','36-24-0004',316800,'36-24-0005','����� ������',117,81679555,NULL,316800,'����',NULL)
INSERT [Work_Orders] VALUES('01/30/2024','���"�','36-24-0011',420000,'36-24-0011','������',107,81679555,NULL,420000,'����',NULL)
INSERT [Work_Orders] VALUES('03/07/2024','���"�','36-24-0005',33600,'36-24-0060','����',107,81679555,NULL,33600,'����',NULL)
INSERT [Work_Orders] VALUES('03/13/2024','���"�','36-24-0006',497685,'36-24-0071','����� ������',107,81679555,NULL,497685,'���� ',NULL)
INSERT [Work_Orders] VALUES('04/08/2024','���"�','97-20-0008',13263,'36-24-100','�����',116,81679555,NULL,13263,'����',NULL)
INSERT [Work_Orders] VALUES('04/08/2024','���"�','97-20-0008',163943.5,'36-24-101','����� ������',118,81679555,NULL,163943.5,'����',NULL)
INSERT [Work_Orders] VALUES('04/08/2024','���"�',NULL,4000000,'36-24-102','���� ���� �������',111,81679555,NULL,4000000,'����',NULL)
INSERT [Work_Orders] VALUES('05/01/2024','���"�','97-20-0008',16866,'36-24-116','�����',114,81679555,NULL,14415,'����',NULL)
INSERT [Work_Orders] VALUES('06/10/2024','���"�',NULL,3900000,'36-24-160','���� ���� �������',111,81679555,NULL,3900000,'����',NULL)
INSERT [Work_Orders] VALUES('07/07/2024','���"�','97-20-0008',39240,'36-24-183','����� ������',109,81679555,NULL,39240,'����',NULL)
INSERT [Work_Orders] VALUES('08/14/2024','���"�',NULL,NULL,'36-24-227','���� ���"�',111,81679555,NULL,7500000,'����',NULL)
INSERT [Work_Orders] VALUES('11/10/2024','���"�',NULL,NULL,'36-24-277','���� ���"�',111,81679555,NULL,11000000,'����',NULL)
INSERT [Work_Orders] VALUES('12/24/2023','���"�',NULL,NULL,'36-24-408','���� ���"�',111,81679555,NULL,9000000,'����',NULL)

GO

 /****** INSERT VALUES TO :  Table [Invoices]    */
 INSERT [Invoices] VALUES('����','36-23-325','17900923','09-11-2023','500180',790,'����� �����',1,'����� �����','���� ���� ��"�','����','����','������',2250,2385,0,'��� ����"�','12-31-2023',NULL,'��',NULL,NULL,2023,'���"�','09-2023')
 INSERT [Invoices] VALUES('����','36-23-325','17900923','09-13-2023','78',790,'����� �����',1,'����� �����','���� �������  ','����','����','���',900,954,0,'��� ����"�','12-31-2023',NULL,'��',NULL,NULL,2023,'���"�','09-2023')
 INSERT [Invoices] VALUES('����','36-23-325','17930923','09-15-2023','3082023',793,'����� ���� ��������',25,'������� �������� ���� �����','������ ����������  ','�����','����','���',4000,4240,0,'��� ����"�','12-10-2023',NULL,'��',NULL,NULL,2023,'���"�','09-2023')
 INSERT [Invoices] VALUES('����','36-23-325','17900923','09-21-2023','1034',790,'����� �����',1,'��������','������ �������  ','��� ���� 2023','����','���',5850,6201,0,'��� ����"�','12-31-2023',NULL,'��',NULL,NULL,2023,'���"�','09-2023')
 INSERT [Invoices] VALUES('����','36-23-325','17900923','09-21-2023','1035',790,'����� �����',1,'��������','������ �������  ','��� ������ 2023','����','���',5850,6201,0,'��� ����"�','12-31-2023',NULL,'��',NULL,NULL,2023,'���"�','09-2023')
 INSERT [Invoices] VALUES('����','36-23-325','17900923','10-01-2023','500186',790,'����� �����',1,'����� �����','���� ���� ��"�  ','����','����','������',2250,2385,0,'��� ����"�','12-31-2023',NULL,'��',NULL,NULL,2023,'���"�','10-2023')
 INSERT [Invoices] VALUES('����','36-23-325','19620923','10-18-2023','19620923',963,'���� ������',37,'����� ����','����','����� ����� ���� ������ 2023','����','������',28000,29400,0,'��� ����"�','12-10-2023','���� ������� �����','��',NULL,NULL,2023,'���"�','09-2023')
 INSERT [Invoices] VALUES('����','36-23-325','19630923','10-18-2023','19630923',963,'���� ������',37,'����"�','����','����� ����� ������ 2023','����','������',28000,29400,0,'��� ����"�','12-10-2023','���� ������� �����','��',NULL,NULL,2023,'���"�','09-2023')
 INSERT [Invoices] VALUES('����','36-23-325','4450923','10-22-2023','4450923',795,'����� ���� ��������',24,'���� ��������','����','��� ���� �������� ������ 2023','����','���',13212.9905660377,14005.77,14005.77,'��� ����"�','12-10-2023',NULL,'���� ������','��','12-20-2023',2023,'���"�','09-2023')
 INSERT [Invoices] VALUES('����','36-23-325','14450923','10-22-2023','14450923',795,'����� ���� ��������',24,'���� ��������','����','����� ���� �������� ������ 2023','����','������',15500,16430,16430,'��� ����"�','12-10-2023',NULL,'���� ������','��','12-20-2023',2023,'���"�','09-2023')
 INSERT [Invoices] VALUES('����','36-23-325','7900923','10-01-2023','7900923',790,'����� �����',1,'����� �����','����','��� ������ ������ 2023','����','���',141141.622641509,149610.12,18068.62,'��� ����"�','12-31-2023','��� ��� ����','���� ������','��','12-20-2023',2023,'���"�','09-2023')
 INSERT [Invoices] VALUES('����','36-23-325','7920923','10-01-2023','7920923',792,'����� ���� ������ �����',29,'����� ����','����','��� ������ ������ 2023','����','���',697176.990566038,739007.61,739007.61,'��� ����"�','12-31-2023',NULL,'���� ������','��','12-20-2023',2023,'���"�','09-2023')
 INSERT [Invoices] VALUES('����','36-23-325','7930923','10-01-2023','7930923',793,'����� ���� ��������',25,'������� ','����','��� ������ ������ 2023','����','���',102954.735849057,109132.02,70070,'��� ����"�','12-31-2023','������� ������� ����','���� ������','��','12-20-2023',2023,'���"�','09-2023')
 INSERT [Invoices] VALUES('����','36-23-325','7940923','10-01-2023','7940923',794,'���� ������',33,'��� ��� ������','����','��� ������ ������ 2023','����','���',77121.8018867925,81749.11,81749.11,'��� ����"�','12-31-2023',NULL,'���� ������','��','12-20-2023',2023,'���"�','09-2023')
 INSERT [Invoices] VALUES('����','36-23-325','7950923','10-01-2023','7950923',795,'����� ���� ��������',21,'��� ���� �����','����','��� ������ ������ 2023','����','���',18297.6886792453,19395.55,0,'��� ����"�','12-31-2023','��� ���� ��"� �����','��',NULL,NULL,2023,'���"�','09-2023')
 INSERT [Invoices] VALUES('����','36-23-325','7871023','11-02-2023','7871023',787,'����� �������',5,'��� ����','����','��� ������ ������� 2023','����','���',9313.88679245283,9872.72,9872.72,'��� ����"�','12-31-2023','��� ����','���� ������','��','12-20-2023',2023,'���"�','10-2023')
 INSERT [Invoices] VALUES('����','36-23-366','7901023','11-02-2023','7901023',790,'����� �����',1,'����� �����','����','��� ������ ������� 2023','����','���',109679.264150943,116260.02,17557.62,'��� ����"�','12-31-2023','��� ��� ����','���� ������','��','12-20-2023',2023,'���"�','10-2023')
 INSERT [Invoices] VALUES('����','36-23-366','7921023','11-02-2023','7921023',792,'����� ���� ������ �����',29,'����� ����','����','��� ������ ������� 2023','����','���',893335.066037736,946935.17,946935.17,'��� ����"�','12-31-2023','�����, ��� ��������','���� ������','��','12-20-2023',2023,'���"�','10-2023')
 INSERT [Invoices] VALUES('����','36-23-366','7931023','11-02-2023','7931023',793,'����� ���� ��������',25,'������� ','����','��� ������ ������� 2023','����','���',100942.764150943,106999.33,65384,'��� ����"�','12-31-2023','������� ������� ����','���� ������','��','12-20-2023',2023,'���"�','10-2023')
 INSERT [Invoices] VALUES('����','36-23-366','7941023','11-02-2023','7941023',794,'���� ������',33,'��� ��� ������','����','��� ������ ������� 2023','����','���',62545.4245283019,66298.15,66298.15,'��� ����"�','12-31-2023','����� ��"� ����','���� ������','��','12-20-2023',2023,'���"�','10-2023')
 INSERT [Invoices] VALUES('����','36-23-366','7951023','11-02-2023','7951023',795,'����� ���� ��������',21,'��� ���� �����','����','��� ������ ������� 2023','����','���',21000.6226415094,22260.66,0,'��� ����"�','01-22-2024','��� ���� �����','��',NULL,NULL,2023,'���"�','10-2023')
 INSERT [Invoices] VALUES('����','36-23-325','17941023','10-30-2023','35',794,'���� ������',38,'������������','����� ��������  ','���� ������������ ������ 2023','���','������',99853,105844.18,105844.18,'��� ����"�','12-10-2023','��� ��������� ���� ���"� ����','���� ������','��','12-20-2023',2023,'���"�','10-2023')
 INSERT [Invoices] VALUES('����','36-23-325','17901023','10-30-2023','80',790,'����� �����',1,'����� �����','���� �������  ','����','����','���',900,954,0,'��� ����"�','12-10-2023',NULL,'��',NULL,NULL,2023,'���"�','10-2023')
 INSERT [Invoices] VALUES('����','36-23-325','17901023','10-30-2023','84',790,'����� �����',1,'����� �����','���� �������  ','����','����','���',900,954,0,'��� ����"�','12-10-2023',NULL,'��',NULL,NULL,2023,'���"�','10-2023')
 INSERT [Invoices] VALUES('����','36-23-325','17901023','10-30-2023','500192',790,'����� �����',1,'����� �����','���� ���� ��"�  ','����','����','������',2250,2385,0,'��� ����"�','12-10-2023',NULL,'��',NULL,NULL,2023,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-23-325','17931023','10-30-2023','40280',793,'����� ���� ��������',25,'������� �������� ���� �����','���� ������  ','�����','����','���',25740,27284.4,0,'��� ����"�','12-14-2023',NULL,'��',NULL,NULL,2023,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-23-325','17931023','11-05-2023','30923',793,'����� ���� ��������',25,'������� �������� ���� �����','������ ����������  ','�����','����','���',4000,4240,0,'��� ����"�','12-14-2023',NULL,'��',NULL,NULL,2023,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-23-325','14451023','11-05-2023','14451023',795,'����� ���� ��������',24,'���� ��������','����','����� ���� �������� ������� 23','����','������',18756.4,19881.784,19881.784,'��� ����"�','12-10-2023',NULL,'���� ������','��','12-20-2023',2023,'���"�','10-2023')
 INSERT [Invoices] VALUES('����','36-23-366','17901123','11-19-2023','1038',790,'����� �����',1,'��������','������ �������  ','��� ������ 2023','����','���',5850,6201,0,'��� ����"�','01-21-2024',NULL,'��',NULL,NULL,2023,'���"�','09-2023')
 INSERT [Invoices] VALUES('����','36-23-366','17901123','11-19-2023','1039',790,'����� �����',1,'��������','������ �������  ','��� ������� 2023','����','���',5850,6201,0,'��� ����"�','01-21-2024',NULL,'��',NULL,NULL,2023,'���"�','10-2023')
 INSERT [Invoices] VALUES('����','36-23-366','17901123','12-01-2023','500198',790,'����� �����',1,'����� �����','���� ���� ��"�  ','����','����','������',2250,2385,0,'��� ����"�','01-21-2024',NULL,'��',NULL,NULL,2023,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-366','17921123','12-01-2023','10062',792,'����� ���� ������ �����',29,'����� ����','�� �������  ','����� ������','����','������',2400,2544,2544,'��� ����"�','12-31-2023',NULL,'���� ������','��','03-30-2024',2023,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-366','17941123','11-28-2023','36',794,'���� ������',38,'������������','����� ��������  ','����� ������������� ����� ������� 2023 ','���','������',114657,121536.42,121536.42,'��� ����"�','02-04-2024',NULL,'���� ������','��','12-20-2023',2023,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-366','17871123','12-03-2023','500268',787,'����� �������',6,'����� �������','�� ������  ','��"� �����- ������ ��� ����� ����� ���"�','����','������',1520,1611.2,1611.2,'��� ����"�','01-23-2024',NULL,'���� ������','��','12-20-2023',2023,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-366','9630923','12-10-2023','9630923',963,'���� ������',37,'����"�','����','��� ����"� ������ 2023','����','���',218777,229716,229716,'��� ����"�','12-31-2023',NULL,'���� ������','��','12-20-2023',2023,'���"�','09-2023')
 INSERT [Invoices] VALUES('����','36-23-366','9620923','12-10-2023','9620923',963,'���� ������',37,'����� ����','����','��� ����� ���� ������ 2023','����','���',7701,8086.05,8086.05,'��� ����"�','12-31-2023',NULL,'���� ������','��','12-20-2023',2023,'���"�','09-2023')
 INSERT [Invoices] VALUES('����','36-23-366','9610923','12-10-2023','9610923',961,'���� ������',34,'�����','����','��� ����� ������ 2023','����','���',4169,4377,4377,'��� ����"�','12-31-2023',NULL,'���� ������','��','03-30-2024',2023,'���"�','09-2023')
 INSERT [Invoices] VALUES('����','36-23-325','4451023','12-10-2023','4451023',795,'����� ���� ��������',24,'���� ��������','����','��� ������ 10/23','����','���',63364,67165.84,67166,'��� ����"�','12-24-2023',NULL,'���� ������','��','12-20-2023',2023,'���"�','10-2023')
 INSERT [Invoices] VALUES('����','36-23-325','4451123','12-10-2023','4451123',795,'����� ���� ��������',24,'���� ��������','����','��� ������ 11/23','����','���',54299,57556.94,57557,'��� ����"�','12-24-2023',NULL,'���� ������','��','12-20-2023',2023,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-23-325','14451123','12-10-2023','14451123',795,'����� ���� ��������',24,'���� ��������','����','����� ���� �������� ������� 2023','����','������',16337,17317.22,17317,'��� ����"�','12-24-2023',NULL,'���� ������','��','12-20-2023',2023,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-23-366','17941223','12-06-2023','37',794,'���� ������',38,'������������','����� ��������  ','����� ������������� ����� ������ 2023 ','���','������',111699,118400.94,118400.94,'��� ����"�','02-04-2024',NULL,'���� ������','��','12-20-2023',2023,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-23-366','7951123','12-03-2023','7951123',795,'����� ���� ��������',21,'��� ���� �����','����','��� ������ ������ 2023','����','���',22859,24231,0,'��� ����"�','01-21-2024',NULL,'��',NULL,NULL,2023,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-23-366','7871123','12-03-2023','7871123',787,'����� �������',5,'��� ����','����','��� ������ ������ 2023','����','���',4889,5182,5182,'��� ����"�','01-21-2024','��� ����','���� ������','��','12-20-2023',2023,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-23-366','7941123','12-03-2023','7941123',794,'���� ������',33,'��� ��� ������','����','��� ������ ������ 2023','����','���',68285,72382,72382.1,'��� ����"�','01-21-2024',NULL,'���� ������','��','12-20-2023',2023,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-23-366','7901123','12-03-2023','7901123',790,'����� �����',1,'����� �����','����',' ��� ������ ���� ������ 2023','����','���',125464,132992,17573.28,'��� ����"�','01-21-2024','��� ��� ����','���� ������','��','12-20-2023',2023,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-23-366','7931123','12-03-2023','7931123',793,'����� ���� ��������',25,'������� ','����','��� ������ ������� 2023','����','���',93533,99145,64956,'��� ����"�','01-21-2024','������� ������� ����','���� ������','��','12-20-2023',2023,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-23-408','7921123','12-03-2023','7921123',792,'����� ���� ������ �����',29,'����� ����','����','��� ������ ������� 2023','����','���',808929,857465,857465,'��� ����"�','02-04-2024',NULL,'���� ������','��','12-20-2023',2023,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-23-366','17921223','12-11-2023','2788',792,'����� ���� ������ �����',30,'�������','���� ����� ��"�  ','���������� ��������','����','������',1170,1240.2,1240,'��� ����"�','02-04-2024','���� ������� ����� �����','���� ������','��','03-30-2024',2023,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-366','17921223','12-11-2023','2790',792,'����� ���� ������ �����',30,'�������','���� ����� ��"�  ','���������� ��������','����','������',1105,1171.3,1171.3,'��� ����"�','02-04-2024','���� ������� ����� �����','���� ������','��','03-30-2024',2023,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','27941223','12-17-2023','02/000015',794,'���� ������',33,'��� ��� ������','����','���� �������� ','����','������',125899,133452.94,133452.94,'��� ����"�','02-26-2024',NULL,'���� ������','��','12-20-2023',2023,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','27871223','12-17-2023','PI23000027',787,'����� �������',11,'���� ������','���� ���  ','���� ������ �������� ����� 1/2','����','������',150000,159000,159000,'��� ����"�','02-13-2024',NULL,'���� ������','��','12-20-2023',2023,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','27871223','12-17-2023','PI23000028',787,'����� �������',11,'���� �����','���� ���  ','���� ����� ����� 1/2','����','������',150000,159000,159000,'��� ����"�','02-13-2024',NULL,'���� ������','��','12-20-2023',2023,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-366','17921223','12-18-2023','10063',792,'����� ���� ������ �����',29,'����� ����','�� �������  ','����� ������','����','������',900,954,954,'��� ����"�','02-04-2024',NULL,'���� ������','��','03-30-2024',2023,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-366','17871123','12-19-2023','5000268',787,'����� �������',6,'����� �������','�� ������  ','������ ��� ���� -�"�� ���� ','����','������',1520,1611.2,1611.2,'��� ����"�','01-21-2024',NULL,'��',NULL,NULL,2023,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-366','17871223','12-18-2023','10065',787,'����� �������',3,'����� ������','�� �������  ','�����','����','������',9600,10176,10176,'��� ����"�','02-04-2024',NULL,'���� ������','��','03-30-2024',2023,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-366','9631023','12-24-2023','9631023',963,'���� ������',37,'����"�','����','��� ����"� ������� 2023','����','���',143425,150596,150596,'��� ����"�','01-21-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','10-2023')
 INSERT [Invoices] VALUES('����','36-23-366','9661023','12-24-2023','9661023',966,'���� ������',34,'����������','����','��� ���������� ������ 2023','����','���',-0.41,-0.43,0,'��� ����"�','01-21-2024',NULL,'��',NULL,NULL,2023,'���"�','10-2023')
 INSERT [Invoices] VALUES('����','36-23-366','9631123','12-26-2023','9631123',963,'���� ������',37,'����"�','����','��� ����"� ������ 2023','����','���',201339,211406,211406,'��� ����"�','01-21-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-23-366','9621123','12-26-2023','9621123',963,'���� ������',37,'����� ����','����','��� ����� ���� ������ 2023','����','���',3670,3853.5,3853.5,'��� ����"�','01-21-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-23-366','9661123','12-26-2023','9661123',966,'���� ������',34,'����������','����','��� ���������� ������ 2023','����','���',4431,4653,4653,'��� ����"�','01-21-2024','����� ������','���� ������','��','03-30-2024',2024,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-23-366','9611123','12-26-2023','9611123',961,'���� ������',34,'�����','����','��� ����� ������ 2023','����','���',20354,21371,21371,'��� ����"�','01-21-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','11-2023')
 INSERT [Invoices] VALUES('����',NULL,'�� ����� ������ ����� ','12-31-2023','5246',790,'����� �����',1,'����� �����','���� �����  ','���� �����','����','������',4000,4240,4240,'�� ����� ������ �����','01-01-2024',NULL,'��',NULL,NULL,2023,'���"�','10-2023')
 INSERT [Invoices] VALUES('����','36-23-408','17951223','12-27-2023','950930/2',795,'����� ���� ��������',26,'������ ����������','��� ����  ','�������� ����� ���� 12/2023','���','������',12000,12720,12720,'��� ����"�','02-26-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','17951223','12-27-2023','729871/1',795,'����� ���� ��������',26,'������ ����������','��� ����  ','���� ���� ������� ����� ���� 12/2023','���','������',8000,8480,8480,'��� ����"�','02-26-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','17951223','12-27-2023','641407/1',795,'����� ���� ��������',26,'������ ����������','��� ����  ','���� ���� ����� ������ ���� ������ 12/2023','���','������',8000,8480,8480,'��� ����"�','02-26-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','17951223','12-27-2023','950930/1',795,'����� ���� ��������',26,'������ ����������','��� ����  ','�������� ����� ���� 11/2023','���','������',4000,4240,4240,'��� ����"�','02-26-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-23-408','17951223','01-05-2024','10018',795,'����� ���� ��������',26,'������ ����������','����� ������  ','������ ��������� ����� 2023','���','������',230833,244682.98,244682.98,'��� ����"�','02-26-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','17951223','01-05-2024','10017',795,'����� ���� ��������',26,'������ ����������','����� ������  ','������ ��������� ������ 2023','���','������',26983,28601.98,28601.98,'��� ����"�','02-26-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-23-366','7941223','01-09-2024','7941223',794,'���� ������',33,'��� ��� ������','����','��� ������ ����� 2023','���� ','���',69031,73172.86,73172.86,'��� ����"�','02-04-2024',NULL,'���� ������','��','03-30-2024',2023,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-366','7951223','01-09-2024','7951223',795,'����� ���� ��������',21,'��� ���� �����','����','��� ������ ����� 2023','����','���',20212,21424.72,0,'��� ����"�','02-04-2024','����� ��� ���� ������-���� 22,261','��',NULL,NULL,2023,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','7901223','01-09-2024','7901223',790,'����� �����',1,'����� �����','����','��� ������ ����� 2023 ','����','���',135681,143821.86,17573.28,'��� ����"�','02-04-2024',NULL,'���� ������','��','12-20-2023',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-366','7871223','01-09-2024','7871223',787,'����� �������',5,'��� ����','����','��� ������ ����� 2023','���� ','���',5037,5339.22,5339.22,'��� ����"�','02-04-2024','���� ����� ��� �� �����. ������ ������ �����','���� ������','��','12-20-2023',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-366','17921223','12-17-2023','2794',792,'����� ���� ������ �����',30,'�������','���� ����� ��"�  ','���������� ��������','����','������',952,1009.12,1009.12,'��� ����"�','02-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','7921223','01-09-2024','7921223',792,'����� ���� ������ �����',29,'����� ����','����','��� ������ ����� 2023','���� ','���',882140,935068.4,935068.4,'��� ����"�','02-04-2024','���� �� ����� 948700, ������','���� ������','��','12-20-2023',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','7931223','01-09-2024','7931223',793,'����� ���� ��������',25,'������� ','����','��� ������ ����� 2023 ','����','���',102706,108868.36,65058,'��� ����"�','02-04-2024','������� ������� ����','���� ������','��','03-30-2023',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','17951223','01-09-2024','1161',795,'����� ���� ��������',26,'������ ����������','����� �����  ','������ ��������� ������ 2023','���','������',18125,19212.5,19212.5,'��� ����"�','02-26-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-23-408','17951223','01-09-2024','1162',795,'����� ���� ��������',26,'������ ����������','����� �����  ','������ ��������� ����� 2023','���','������',77615,82271.9,82271.9,'��� ����"�','02-26-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-366','14451223','01-09-2024','14451223',795,'����� ���� ��������',24,'���� ��������','����','����� ���� �������� ����� 2023','���� ','������',23399,24802.94,24802.94,'��� ����"�','02-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','37871223','01-09-2024','207',787,'����� �������',5,'������','���� ��� ��"�  ','�����  8 ������ ����� �������','���� ','������',106400,112784,112784,'��� ����"�','02-26-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','37871223','01-09-2024','208',787,'����� �������',5,'��� �����','���� ��� ��"�  ','�����  8 ������ ','���� ','������',148800,157728,157728,'��� ����"�','02-26-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-366','4451223','01-21-2024','4451223',795,'����� ���� ��������',24,'���� ��������','����','��� ������ ���� �������� ����� 2023 ','���� ','���',61506,65196.36,65196.36,'��� ����"�','02-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-366','37941223','01-21-2024','02/000012',794,'���� ������',33,'��� ��� ������','��� ������  ','������� ������ ','���','������',3300,3498,3498,'��� ����"�','03-05-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','10-2023')
 INSERT [Invoices] VALUES('����','36-23-408','17920124','01-21-2024','33',792,'����� ���� ������ �����',30,'�������','��� ����  ','��������� �������� ','����','������',643,681.58,681.58,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-366','27921223','01-21-2024','2802',792,'����� ���� ������ �����',30,'�������','���� ����� ��"�  ','��������� �������� ','����','������',1105,1171.3,1171.3,'��� ����"�','03-05-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-366','27921223','01-21-2024','2804',792,'����� ���� ������ �����',30,'�������','���� ����� ��"�  ','��������� �������� ','����','������',1105,1171.3,1171.3,'��� ����"�','03-05-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','17940124','01-21-2024','02/000108',794,'���� ������',33,'��� ��� ������','��� ������  ','����� ��� ������ �9 ��� ��� ','���','������',6150,6519,6519,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930524','05-28-2024','118',793,'����� ���� ��������',25,'������� �������','CC','����� �������� ','���','������',445,471.7,471.7,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17920124','01-21-2024','31',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� ������� ','����','������',2360,2501.6,2501.6,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','17920124','01-21-2024','2806',792,'����� ���� ������ �����',30,'�������','���� ����� ��"�  ','��������� �������� ','����','������',866,917.96,917.96,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','9621223','01-21-2024','9621223',963,'���� ������',37,'����� ����','����','��� ����� ����  ����� 2023','����','���',305,320.25,320.25,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','9631223','01-21-2024','9631223',963,'���� ������',37,'����"�','����','��� ����"� ����� 2023','����','���',227320,238686,238686,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','9611223','01-21-2024','9611223',961,'���� ������',34,'�����','����','��� ����� ����� 2023 ','����','���',5658,5940.9,5940.9,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-366','19631223','01-21-2024','19631223',963,'���� ������',37,'����"�','����','����� ����� ����� 2023','����','������',31900,33495,33495,'��� ����"�','03-05-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('������','36-23-403','211223','01-22-2024','211223',NULL,'����� �������',5,'�����','����� �����  ','�����  ����� ������ �����','���� ','������',0,66600,66600,'��� ����"�','02-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-405','21122023','01-22-2024','21122023',787,'����� �������',5,'�� ���� ','����� �����  ','�����   ����� ������ ����� ','���� ','������',0,53040,53040,'��� ����"�','02-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','17930124','01-23-2024','2758',793,'����� ���� ��������',25,'������� �������','��� �����  ','����� �������� ����� ��� ','���','������',2808,2976.48,2976.48,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-366','27931223','01-23-2024','2756',793,'����� ���� ��������',25,'������� �������','���� ����� ��"�  ','����� �������� ','���','������',483,511.98,511.98,'��� ����"�','03-05-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','09-2023')
 INSERT [Invoices] VALUES('����','36-23-366','57901223','01-15-2024','3178',790,'����� �����',1,'����� �����','��� ��������  ','��� ����� 2023','����','���',41535,44027.1,0,'��� ����"�','03-31-2024',NULL,'��',NULL,NULL,2023,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','17930124','01-23-2024','11003',793,'����� ���� ��������',25,'������� �������','���� ���������  ','����� �������� ','���','������',840,890.4,890.4,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-366','27931223','01-28-2024','301023',793,'����� ���� ��������',25,'������� �������� ���� �����','������ ����������  ','�����','����','���',2933.33,3109.3298,0,'��� ����"�','03-05-2024',NULL,'��',NULL,NULL,2023,'���"�','10-2023')
 INSERT [Invoices] VALUES('����','36-23-366','17900124','01-31-2024','500204',790,'����� �����',1,'����� �����','���� ���� ��"�  ','����','����','������',2250,2385,2385,'��� ����"�','03-05-2024',NULL,'��',NULL,NULL,2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17870124','01-31-2024','10067',787,'����� �������',3,'����� ������','�� �������  ','����� ������','����','������',2400,2544,2544,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17920124','01-31-2024','10068',792,'����� ���� ������ �����',29,'����� ����','�� �������  ','����� ������','����','������',1500,1590,1590,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17900224','02-04-2024','500209',790,'����� �����',1,'����� �����','���� ���� ��"�  ','����','����','������',2250,2385,2385,'��� ����"�','04-14-2024',NULL,'��',NULL,NULL,2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17950124','02-05-2024','310124',795,'����� ���� ��������',22,'����� �������','������ �����  ','����� �������  ���"� ','���� ','������',210363,222984.78,12984.78,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17930124','02-04-2024','3012024',793,'����� ���� ��������',25,'������� �������� ���� �����','������ ����������  ','������ �����  �����- ����� 2023','����','���',5000,5300,0,'��� ����"�','03-10-2024',NULL,'��',NULL,NULL,2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-366','4450124','02-06-2024','4450124',795,'����� ���� ��������',24,'���� ��������','����','��� ������ ���� �������� ����� 2023 ','����','���',39844,42234.64,42234.64,'��� ����"�','02-26-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17950124','02-06-2024','10020',795,'����� ���� ��������',26,'������ ����������','����� ������  ','������ ��������� ����� 2024','���','������',243417,258022.02,258022.02,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����',NULL,'17920824','08-26-2024','9996',792,'����� ���� ������ �����',30,'�������','CC','����','�����','������',7578,8032.68,8032.68,'���� �����','08-26-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17950124','02-06-2024','729871/2',795,'����� ���� ��������',26,'������ ����������','��� ����  ','���� ���� ������� ����� ���� 01/2024','���','������',12000,12720,12720,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17950124','02-06-2024','641407/2',795,'����� ���� ��������',26,'������ ����������','��� ����  ','���� ����  ����� ������ 01/2024','���','������',12000,12720,12720,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17950124','02-06-2024','950930/3',795,'����� ���� ��������',26,'������ ����������','��� ����  ','�������� ����� ���� ����� 2024','���','������',12000,12720,12720,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','9660124','02-06-2024','9660124',966,'���� ������',34,'����������','����','��� ���������� ����� 2024','����','���',3268.7,3432.135,3432.135,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','9620124','02-06-2024','9620124',963,'���� ������',37,'����� ����','����','��� ����� ���� ����� 2024','����','���',102.8,107.94,107.94,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','9630124','02-06-2024','9630124',963,'���� ������',37,'����"�','����','��� ����� ����� 2024','����','���',217475,228348.75,228348.75,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','9610124','02-06-2024','9610124',961,'���� ������',34,'�����','����','��� ����� ����� 2024','����','���',14376.5,15095.325,15095.325,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17900224','02-07-2024','86',790,'����� �����',1,'����� �����','���� �������  ','����','����','���',900,954,0,'��� ����"�','04-14-2024',NULL,'��',NULL,NULL,2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','19610124','02-14-2024','19610124',961,'���� ������',34,'�����','����','����� ����� ����� 2024','����','������',8310,8725.5,8725.5,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','7950124','02-14-2024','7950124',795,'����� ���� ��������',21,'��� ���� �����','����','��� ������ ��� ��� ����� ����� 2024','����','���',20655,21894.3,0,'��� ����"�','03-10-2024',NULL,'��',NULL,NULL,2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','7900124','02-14-2024','7900124',790,'����� �����',1,'����� �����','����','��� ������ ����� 2024','����','���',114927,121822.62,17556,'��� ����"�','03-10-2024','��� ��� ����','���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','7940124','02-14-2024','7940124',794,'���� ������',33,'��� ��� ������','����','��� ������ ����� 2024','����','���',66240,70214.4,70214.4,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-366','7870124','02-14-2024','7870124',787,'����� �������',5,'��� ���� ����� ������ ������ ','����','��� ������ ����� 2024','����','���',6564.15094339623,6958,6958,'��� ����"�','02-26-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','7920124','02-14-2024','7920124',792,'����� ���� ������ �����',29,'����� ����','����','��� ������ ����� 2024','����','���',872890,925263.4,925263.4,'��� ����"�','03-05-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','7930124','02-14-2024','7930124',793,'����� ���� ��������',25,'������� ','����','��� ������ ����� 2024','����','���',97816.4716981132,103685.46,75868,'��� ����"�','03-10-2024','������� ������� ����','���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910224','02-14-2024','1305',791,'����� ���� ��',16,'�� �������� ������ ����� ','��� ������  ','����� ������ ����� �� �������','�����','������',1605,1701.3,1701.3,'��� ����"�','04-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17920224','02-14-2024','38',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� ������� ������ ','���','������',760,805.6,805.6,'��� ����"�','04-14-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17920224','02-14-2024','37',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� ������� ������ ','�����','������',1053,1116.18,1116.18,'��� ����"�','04-14-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17920224','02-14-2024','35',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� ������� ������ ','�����','������',982,1040.92,1040.92,'��� ����"�','04-14-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17920224','02-14-2024','34',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� ������� ������ ','�����','������',819,868.14,868.14,'��� ����"�','04-14-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','57900124','02-22-2024','3181',790,'����� �����',1,'����� �����','��� ��������  ','��� ����� 2024','����','���',41535,44027.1,0,'��� ����"�','03-10-2024',NULL,'��',NULL,NULL,2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','57901123','02-22-2024','3175',790,'����� �����',1,'����� �����','��� ��������  ','��� ������ 2023','����','���',41535,44027.1,0,'��� ����"�','03-05-2024',NULL,'��',NULL,NULL,2023,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-23-408','17930224','02-25-2024','250224',793,'����� ���� ��������',25,'������� �������','���� ������  ','���� ������ ������ ','���','������',1600,1696,1696,'��� ����"�','04-14-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910224','02-25-2024','40060',791,'����� ���� ��',12,'������� ���� ���� ��������','������  ','����� ������-����� ����� ����� ����� ������� 1/24','����','���',23400,24804,24804,'��� ����"�','04-04-2024','����� ��� ���� ����� ����� ������','���� ������','��','06-13-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910224','02-25-2024','40061',791,'����� ���� ��',17,'���� ����','������  ','����� ������ ���� ���� 01/ 24','����','���',17550,18603,18603,'��� ����"�','04-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910224','02-25-2024','40062',791,'����� ���� ��',12,'������� ���� ���� ��������','������  ','����� ������ ����� ����� ���� ������� 2/24','����','���',23400,24804,24804,'��� ����"�','04-04-2024','����� ��� ���� ����� ����� ������','���� ������','��','06-13-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910224','02-25-2024','40063',791,'����� ���� ��',17,'���� ���� ','������  ','����� ������ ���� ���� 02/24','����','���',17550,18603,18603,'��� ����"�','04-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17900224','02-29-2024','1042',790,'����� �����',1,'��������','������ �������  ','��� ������ 2023','����','���',5850,6201,0,'��� ����"�','04-14-2024',NULL,'��',NULL,NULL,2023,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-23-408','17900224','02-29-2024','1044',790,'����� �����',1,'��������','������ �������  ','��� ����� 2023','����','���',5850,6201,0,'��� ����"�','04-14-2024',NULL,'��',NULL,NULL,2023,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-29-2024','22917',793,'����� ���� ��������',25,'������� �������','CC','���� ','���','������',17,18.02,18.02,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17930224','02-29-2024','1825',793,'����� ���� ��������',25,'������� �������','����� ���������  ','���� ������� 17/12','����','������',1029.6,1091.376,1091.376,'��� ����"�','04-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910224','02-29-2024','19224',791,'����� ���� ��',17,'���� ����','������� �����  ','����� �������� ','����','������',391,414.46,414.46,'��� ����"�','04-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910224','02-29-2024','20224',791,'����� ���� ��',17,'���� ����','������� �����  ','����� �������� ','����','������',262,277.72,277.72,'��� ����"�','04-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910224','02-29-2024','25224',791,'����� ���� ��',17,'���� ���� ','������� �����  ','����� �������� ','����','������',385,408.1,408.1,'��� ����"�','04-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17950224','03-04-2024','10021',795,'����� ���� ��������',26,'������ ����������','����� ������  ','������ ��������� ������ 2024','����','������',253246,268440.76,268440.76,'��� ����"�','04-16-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17950224','03-04-2024','950930/4',795,'����� ���� ��������',26,'������ ����������','��� ����  ','�������� ����� ���� ������ 2024','����','������',16000,16960,16960,'��� ����"�','04-16-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17950224','03-04-2024','641407/3',795,'����� ���� ��������',26,'������ ����������','��� ����  ','���� ����  ����� ������ 02/2024','����','������',12000,12720,12720,'��� ����"�','04-16-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17950224','03-04-2024','729871/3',795,'����� ���� ��������',26,'������ ����������','��� ����  ','���� ���� ������� ����� ���� 02/2024','����','������',12000,12720,12720,'��� ����"�','04-16-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','7900224','03-04-2024','7900224',790,'����� �����',1,'����� �����','����','��� ������ ������ 2024','����','������',115689.5,122630.87,122630.87,'��� ����"�','04-04-2024','��� ��� ����','���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','7870224','03-04-2024','7870224',787,'����� �������',5,'��� ���� ','����','��� ������ ������ 2024','����','���',20534,21766.04,21766.04,'��� ����"�','04-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','7930224','03-04-2024','7930224',793,'����� ���� ��������',25,'������� ','����','��� ������ ������ 2024','����','���',135209.6,143322.176,86011,'��� ����"�','04-08-2024','������� ������� ����','���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','7920224','03-04-2024','7920224',792,'����� ���� ������ �����',29,'����� ����','����','��� ������ ������ 2024','����','���',853813.7,905042.522,905042.522,'��� ����"�','04-08-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','7940224','03-04-2024','7940224',794,'���� ������',33,'��� ��� ������','����','��� ������ ������ 2024','����','���',67340.49,71380.9194,71380.9194,'��� ����"�','04-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','7910224','03-05-2024','7910224',791,'����� ���� ��',17,'���� ����','����','��� ����� ���� ���� ������ 24','����','���',7325,7764.5,7764.5,'��� ����"�','04-08-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','19630224','03-06-2024','19630224',963,'���� ������',37,'����"�','����','����� ����� ������ 2024','����','������',43000,45150,45150,'��� ����"�','04-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','19660224','03-06-2024','19660224',966,'���� ������',34,'����������','����','����� ��������� ������ 2024','����','������',1192,1251.6,1251.6,'��� ����"�','04-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','9610224','03-06-2024','9610224',961,'���� ������',34,'�����','����','��� ����� ������ 2024','����','���',21688.6,22773.03,22773.03,'��� ����"�','04-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','9620224','03-06-2024','9620224',963,'���� ������',37,'����� ����','����','��� ����� ����� 2024','����','���',1608,1688.4,1688.4,'��� ����"�','04-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','9630224','03-06-2024','9630224',963,'���� ������',37,'����"�','����','��� ���"�� ������ 2024','����','���',239462.5,251435.625,251435.625,'��� ����"�','04-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','9660224','03-06-2024','9660224',966,'���� ������',34,'����������','����','��� ������ ��������� ������ 2024','����','���',4151,4358.55,4358.55,'��� ����"�','04-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17940224','03-07-2024','38',794,'���� ������',38,'������������','����� ��������  ','����� ������������� �����  ����� 2023','���','������',117247,124281.82,124281.82,'��� ����"�','04-14-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17940224','03-07-2024','39',794,'���� ������',38,'������������','����� ��������  ','����� ������������� ����� ����� 2024','���','������',108261,114756.66,114756.66,'��� ����"�','04-14-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','7950224','03-11-2024','7950224',795,'����� ���� ��������',21,'��� ���� �����','����','��� ������ ��� ��� ����� ������ 2024','����','���',20853,22104.18,0,'��� ����"�','04-04-2024',NULL,'��',NULL,NULL,2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17930324','03-12-2024','IN240000321',793,'����� ���� ��������',25,'������� �������','����� ���  ','���� ������� ������� ','���','������',2016,2136.96,2136.96,'��� ����"�','05-12-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17920324','03-12-2024','10070',792,'����� ���� ������ �����',29,'����� ����','�� �������  ','����� ������','����','������',1800,1908,1908,'��� ����"�','05-12-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17940324','03-12-2024','474',794,'���� ������',33,'��� ��� ������','����� �������  ','������ ���� ��� ��� ���� ��� 2024','���','������',3744,3968.64,3968.64,'��� ����"�','05-28-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17930324','03-12-2024','60324',793,'����� ���� ��������',25,'�������� ��������  �������','���� ���������  ','����� �������� ����� ','����','������',2120,2247.2,0,'��� ����"�','05-12-2024',NULL,'��',NULL,NULL,2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17920324','03-12-2024','41',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� �������� ','�����','������',772,818.32,818.32,'��� ����"�','05-12-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17930324','03-12-2024','177',793,'����� ���� ��������',25,'������� �������','����� �������  ','����� �������� �� ��� ������ ','���','������',1300,1378,1378,'��� ����"�','05-12-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17930324','03-12-2024','400042',793,'����� ���� ��������',25,'������� �������','��� ������� ������  ','����� �������� ','���','������',190,201.4,201.4,'��� ����"�','05-12-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17900224','03-17-2024','88',790,'����� �����',1,'����� �����','���� �������  ','����','����','���',900,954,0,'��� ����"�','04-14-2024',NULL,'��',NULL,NULL,2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','19610224','03-18-2024','19610224',961,'���� ������',34,'�����','����','����� ����� ������ 2024','����','������',477059,500911.95,500911.95,'��� ����"�','04-04-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17950324','03-18-2024','180324',795,'����� ���� ��������',20,'������ ������ ','������ �����  ','������ ������ ������� �� ��� 2024 ','����','������',83300,88298,88298,'��� ����"�','05-12-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-23-408','14450224','03-20-2024','14450224',795,'����� ���� ��������',24,'���� ��������','����','����� ���� �������� ������ 2024','����','������',24182.86,25633.8316,25633.8316,'��� ����"�','04-16-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-18-2024','80724',793,'����� ���� ��������',25,'�������� ��������  �������','CC','����� ���� ���� +�� ���� +���� ���� ��� ����� ','����','������',42000,44520,44520,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910224','02-25-2024','376010486',791,'����� ���� ��',17,'���� ���� ','���� �����  ','��� ��� ���� ���� ','����','������',147,155.82,155.82,'��� ����"�','04-04-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910224','02-25-2024','190224',791,'����� ���� ��',17,'���� ���� ','������� �����  ','��� ������ ������� ���� ���� ','����','������',144.7,153.382,153.382,'��� ����"�','04-04-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910224','02-25-2024','150224',791,'����� ���� ��',17,'���� ���� ','������� �����  ','�� ����, ��� , ��� ','����','������',112.9,119.674,119.674,'��� ����"�','04-04-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910224','02-25-2024','72',791,'����� ���� ��',17,'���� ���� ','������ �����  ','���� ����� ����� ���� ','����','������',137,145.22,145.22,'��� ����"�','04-04-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910224','02-25-2024','74',791,'����� ���� ��',17,'���� ���� ','������ �����  ','��� ���� ������� ���� ���� ','����','������',150,157.5,157.5,'��� ����"�','04-04-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910224','02-25-2024','76',791,'����� ���� ��',17,'���� ���� ','������ �����  ','���� ���� ���� ','����','������',60,63.6,63.6,'��� ����"�','04-04-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-18-2024','80724',793,'����� ���� ��������',25,'�������� ��������  �������','CC','������ ���� ,������� , ���� ����� ���� ��� ����� ','����','������',19260,20415.6,20415.6,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17930324','03-21-2024','290224',793,'����� ���� ��������',25,'������� �������� ���� �����','������ ����������  ','������ ������ ������� �� ��� 2024','����','���',5000,5300,0,'��� ����"�','05-12-2024',NULL,'��',NULL,NULL,2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17920324','03-21-2024','39',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� ������� ������ ','�����','������',795,842.7,842.7,'��� ����"�','05-12-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17870424','03-21-2024','IN244000110',787,'����� �������',3,'����� ������','������ ����  ','����� ��� ��� ����� -������ 2024','����','������',190500,201930,201930,'��� ����"�','06-05-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','11-07-2024','7112024',793,'����� ���� ��������',25,'������� �������','CC','���� ','����','������',3888,4121.28,4121.28,'���� �����','11-07-2024',NULL,'��',NULL,NULL,2024,'���"�','11-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17930324','03-26-2024','68',793,'����� ���� ��������',25,'������� �������','������ �����  ','���� ����� ','���','������',500,530,530,'��� ����"�','05-12-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17930324','03-26-2024','68',793,'����� ���� ��������',25,'������� �������','������ �����  ','���� ����� ','���','������',125,132.5,132.5,'��� ����"�','05-12-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����',NULL,'17930824','09-08-2024','10947262',793,'����� ���� ��������',25,'������� ������� ','CC','�����','���','������',97.6,103.456,103.456,'���� �����','09-08-2024',NULL,'���� ������','��',NULL,2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17930324','03-26-2024','260324',793,'����� ���� ��������',25,'������� �������',' SUPERMARKET ','��� ,�� ������ ','���','������',72.8,77.168,77.168,'��� ����"�','05-12-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910324','03-26-2024','40065',791,'����� ���� ��',17,'���� ����','������  ','����� ������ -���� ���� ��� 2024','����','���',17550,18603,18603,'��� ����"�','05-02-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910324','03-26-2024','40064',791,'����� ���� ��',12,'������� ���� ���� ��������','������  ','����� ������ -����� ����� ����� ����� ������� ��� 24','����','���',23400,24804,24804,'��� ����"�','05-02-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17870324','03-26-2024','50003',787,'����� �������',5,'��� ������ ','����� �������  ','����� ����� ����� , ������ ��������  ','���� ','������',4499.8,4769.788,4769.788,'��� ����"�','05-28-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17870324','03-27-2024','51',787,'����� �������',5,'��� ���� ','���� ����  ','����� ����� ��� ����� 3/24','����','������',8000,8480,8480,'��� ����"�','05-28-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930524','05-28-2024','10324',793,'����� ���� ��������',25,'������� �������',' SUPERMARKET ','�� ����','���','������',86,91.16,91.16,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910324','04-03-2024','233000026',791,'����� ���� ��',16,'�� �������� ������ ����� ','�������� ��"�  ','����� ������ ������ ������ ���� ������ ������� ����� �������','����','������',37440,39686.4,39686.4,'��� ����"�','05-02-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����',NULL,'�� ����� ������ ����� ','04-03-2024','233000025',791,'����� ���� ��',16,'�� �������� ������ ����� ','�������� ��"�  ','10% ������ ��� ����� ���� ����� ����� ������ �� ������ ','����','������',25155,26664.3,26664.3,'��� ����"�','05-27-2024',NULL,'����-���','��',NULL,2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17950324','03-31-2024','641407/4',795,'����� ���� ��������',26,'������ ����������','��� ����  ','���� ���� ����� ������ 03/24','���','������',8000,8480,8480,'��� ����"�','05-12-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17950324','03-31-2024','729871/4',795,'����� ���� ��������',26,'������ ����������','��� ����  ','���� ���� ������� ����� ���� 03/24','���','������',16000,16960,16960,'��� ����"�','05-12-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17950324','03-31-2024','950930/5',795,'����� ���� ��������',26,'������ ����������','��� ����  ','�������� ����� ���� 03/24','���','������',8000,8480,8480,'��� ����"�','05-12-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17870324','03-31-2024','307',787,'����� �������',5,'������','���� ��� ��"�  ','8 ������ �����  ����� ������� ','���� ','������',89600,94976,94976,'��� ����"�','05-28-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17870324','03-31-2024','308',787,'����� �������',18,'������','���� ��� ��"�  ','8 ������ �����  ����� ��������  ','���� ','������',16800,17808,17808,'��� ����"�','05-28-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17870324','03-31-2024','304',787,'����� �������',5,'��� �����','���� ��� ��"�  ','8 ������ ������ �����  ','���� ','������',110400,117024,117024,'��� ����"�','05-28-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910324','03-31-2024','310324',791,'����� ���� ��',17,'���� ���� ','������� �����  ','���� ����� ���� ','����','������',80,84.8,84.8,'��� ����"�','05-02-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910324','03-31-2024','310324',791,'����� ���� ��',17,'���� ���� ','������� �����  ','����� �������� ','����','������',490,519.4,519.4,'��� ����"�','05-02-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910324','03-31-2024','310324',791,'����� ���� ��',17,'���� ���� ','������� �����  ','����� �������� ','����','������',348,368.88,368.88,'��� ����"�','05-02-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910324','03-31-2024','99',791,'����� ���� ��',17,'���� ���� ','������ �����  ','���� �������� ','����','������',150,159,159,'��� ����"�','05-02-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910324','03-31-2024','100',791,'����� ���� ��',17,'���� ���� ','������ �����  ','������� �������� +���� ','����','������',45,47.7,47.7,'��� ����"�','05-02-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930524','05-28-2024','25424',793,'����� ���� ��������',25,'������� �������',' SUPERMARKET ','����� ','���','������',49,51.94,51.94,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-29-2024','30724',793,'����� ���� ��������',25,'������� �������',' SUPERMARKET ','��� ������ ','���','������',20.9,22.154,22.154,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910324','04-01-2024','681',791,'����� ���� ��',17,'���� ���� ','���� ��"�  ','����� ������� ���� ���� ','����','������',2100,2226,2226,'��� ����"�','05-02-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17950324','04-03-2024','11',795,'����� ���� ��������',26,'������ ����������','����� �����  ','������ ��������� 03/24 ','���','������',67555,71608.3,71608.3,'��� ����"�','05-12-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17950324','04-03-2024','12',795,'����� ���� ��������',26,'������ ����������','����� �����  ','������ ��������� 02/24 ','���','������',86322,91501.32,91501.32,'��� ����"�','05-12-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('������','36-23-405','002/2024','03-24-2024','002/2024',NULL,'����� �������',5,'�� ���� ','����� �����  ','����� ����� 12/23 �� 3/24','����','������',0,140160,140160,'��� ����"�','05-02-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('������','36-23-403','001/2024','03-24-2024','001/2024',NULL,'����� �������',5,'�����','����� �����  ','����� �����  12/23 �� 3/24','���� ','������',0,227400,227400,'��� ����"�','04-07-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-29-2024','100724',793,'����� ���� ��������',25,'������� �������',' SUPERMARKET ','��� ��� ����"� ','���','������',127.7,135.362,135.362,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930624','07-01-2024','15805',793,'����� ���� ��������',25,'������� �������','OFFICE','����� ������� ','���','������',150,159,159,'��� ����"�','08-04-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17920424','04-03-2024','40',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� ������� ������ ','�����','������',538,570.28,570.28,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17920424','04-03-2024','42',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� ������� ������ ','�����','������',889,942.34,942.34,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930624','07-01-2024','15815',793,'����� ���� ��������',25,'������� �������','OFFICE','������ ','���','������',110,116.6,116.6,'��� ����"�','08-04-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17870424','04-04-2024','50014',787,'����� �������',5,'��� ������ ','����� �������  ','���� ����� �� ��� ����� ���� ������� 45 ','���� ','������',6187,6558.22,6558.22,'��� ����"�','06-05-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17940324','04-07-2024','40',794,'���� ������',38,'������������','����� ��������  ','����� ������������� ����� ������ 2024','���','������',112552,119305.12,119305.12,'��� ����"�','05-28-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-23-408','1790324','04-07-2024','91',790,'����� �����',1,'����� �����','���� �������  ','����','����','���',900,954,0,'��� ����"�','05-20-2024',NULL,'��',NULL,NULL,2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-23-408','1790324','04-07-2024','90',790,'����� �����',1,'����� �����','���� �������  ','����','����','���',900,954,0,'��� ����"�','05-20-2024',NULL,'��',NULL,NULL,2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17870424','04-14-2024','10962',787,'����� �������',3,'����� ������','��� ������  ','���� ����� ���� ������ ��� 24','�����','������',143404.56,152008.8336,152008.8336,'��� ����"�','06-05-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-102','57900224','03-01-2024','3183',790,'����� �����',1,'����� �����','��� ��������  ','��� ������ 2024','����','���',41535,44027.1,0,'��� ����"�','06-05-2024',NULL,'��',NULL,NULL,2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-24-102','57900324','04-01-2024','3186',790,'����� �����',1,'����� �����','��� ��������  ','��� ��� 2024','����','���',41535,44027.1,0,'��� ����"�','06-05-2024',NULL,'��',NULL,NULL,2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','9610324','04-16-2024','9610324',961,'���� ������',34,'�����','����','��� ����� ��� 2024','����','���',20000.6,21000.63,21000.6,'��� ����"�','05-22-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','9620324','04-16-2024','9620324',963,'���� ������',37,'����� ����','����','��� ����� ����� ��� 2024','����','���',-135.9,-142.695,-142.695,'��� ����"�','05-22-2024',NULL,'��',NULL,NULL,2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','9660324','04-16-2024','9660324',966,'���� ������',34,'����������','����','��� ������ ��������� ��� 2024 ','����','���',4716.6,4952.43,4952.43,'��� ����"�','05-22-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','9630324','04-16-2024','9630324',963,'���� ������',37,'����"�','����','��� ���"�� ��� 2024','����','���',288965,303413.25,303413.25,'��� ����"�','05-22-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','4450324','04-16-2024','4450324',795,'����� ���� ��������',24,'���� ��������','����','��� ������ ���� �������� ��� 2024','����','���',70975.15,75233.659,75233.659,'��� ����"�','05-22-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-23-408','14450324','04-16-2024','14450324',795,'����� ���� ��������',24,'���� ��������','����','����� ���� �������� ��� 2024','����','������',32672,34632.32,34632.32,'��� ����"�','05-12-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-23-408','7910324','04-17-2024','7910324',791,'����� ���� ��',17,'���� ���� ','����','����� ���� �������� ��� 2024','����','���',11240.7,11915.142,11915.142,'��� ����"�','05-12-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-23-408','7940324','04-17-2024','7940324',794,'���� ������',33,'��� ��� ������','����','��� ������ ��� ��� ���� ��� 24','����','���',76129.2452830189,80697,80697,'��� ����"�','05-12-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-23-408','7870324','04-17-2024','7870324',787,'����� �������',5,'��� ���� ','����','��� ������ ��� 24','����','���',17899.0566037736,18973,18973,'��� ����"�','05-12-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-23-408','7950324','04-17-2024','7950324',795,'����� ���� ��������',21,'��� ���� �����','����','��� ������ ��� 24','����','���',22839.2075471698,24209.56,0,'��� ����"�','05-12-2024',NULL,'��',NULL,NULL,2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','7920324','04-17-2024','7920324',792,'����� ���� ������ �����',29,'����� ����','����','��� ������ ��� 2024','����','���',929906.603773585,985701,985701,'��� ����"�','05-12-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17930424','04-30-2024','240324',793,'����� ���� ��������',25,'������� �������','���� ��� ��"�  ','����� ������ , ����� ������ ','���','������',4400,4664,4664,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-30-2024','100724',793,'����� ���� ��������',25,'������� �������','SMART','����� ���� ������ ������ ������','���','������',2246,2380.76,2380.76,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17910424','04-30-2024','40066',791,'����� ���� ��',12,'������� ���� ���� ��������','������  ','����� ������ ����� ����� ����� ����� 24','����','���',23400,24804,24804,'��� ����"�','06-10-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17910424','04-30-2024','40067',791,'����� ���� ��',17,'���� ����','������  ','����� ������- ���� ���� 04/24','����','���',7020,7441.2,7441.2,'��� ����"�','06-10-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17930424','04-30-2024','30324',793,'����� ���� ��������',25,'������� �������� ���� �����','������ ����������  ','�����','����','���',5000,5300,0,'��� ����"�','06-30-2024',NULL,'��',NULL,NULL,2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17920424','04-30-2024','45',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� �������� 04/24','�����','������',614,650.84,650.84,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17920424','04-30-2024','46',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� �������� 04/24','�����','������',702,744.12,744.12,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','10-27-2024','40216',790,'����� �����',1,'����� �����','SMART','����� 1/4 ���"� ','����','������',24570,26044.2,26044.2,'���� �����','10-27-2024',NULL,'��',NULL,NULL,2024,'���"�','10-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17910424','04-30-2024','210424',791,'����� ���� ��',17,'���� ���� ','������� �����  ','����� �������� ','����','������',375.9,398.454,398.454,'��� ����"�','06-10-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17910424','04-30-2024','220424',791,'����� ���� ��',17,'���� ���� ','������� �����  ','����� �������� ','����','������',490.8,520.248,520.248,'��� ����"�','06-10-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17910424','04-30-2024','230424',791,'����� ���� ��',17,'���� ���� ','������� �����  ','����� �������� ','����','������',398.3,422.198,422.198,'��� ����"�','06-10-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17870424','04-10-2024','IN244000300',787,'����� �������',3,'����� ������','������ ����  ','����� ��� ��� ��� 2024','����','������',142800,151368,151368,'��� ����"�','06-05-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17930424','05-02-2024','2828',793,'����� ���� ��������',25,'������� �������','���� ����� ��"�  ','����� �������� ����� ������� ','���','������',442,468.52,468.52,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����',NULL,'17930824','09-02-2024','180824',793,'����� ���� ��������',25,'������� �������','SMART','������ ������ ','����','������',3300,3498,3498,'���� �����','09-02-2024',NULL,'��',NULL,NULL,2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','10-27-2024','151024',793,'����� ���� ��������',25,'������� ������� ','SMART','���� �������� ','���','������',9560,10133.6,10133.6,'���� �����','10-27-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','10-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17900624','07-04-2024','13524',790,'����� �����',1,'����� �����','SMART','����� ���� ��� ����� ','����','������',3448.8,3655.728,0,'��� ����"�','08-18-2024',NULL,'��',NULL,NULL,2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17910524','05-28-2024','261',791,'����� ���� ��',17,'���� ����','������','������ �������� ����� ����','����','������',3014,3194.84,3194.84,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17870424','05-05-2024','11017',787,'����� �������',3,'����� ������','��� ������  ','���� ����� ���� ����� 24','�����','������',12645.36,13404.0816,13404.0816,'��� ����"�','06-05-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17910424','05-05-2024','11018',791,'����� ���� ��',12,'������� ���� ���� ��������','��� ������  ','���� ������ ������ ����� ��� ����� 24  ','�����','������',65819.5,69768.67,69768.67,'��� ����"�','06-10-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-102','7900324','04-03-2024','7900324',790,'����� �����',1,'����� �����','����','��� ������ ��� 24','����','���',118487.6,125596.856,18361.35,'��� ����"�','05-22-2024','��� ��� ����','���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-21-2024','210724',793,'����� ���� ��������',25,'������� �������','������','��� ������ ��������� ����� ������� ���� ','���','������',121300,128578,128578,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-102','7930324','04-03-2024','7930324',793,'����� ���� ��������',25,'������� ','����','��� ������ 03/24','����','���',131794.5,139702.17,88349,'��� ����"�','05-22-2024','������� ������� ����','���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910724','07-28-2024','250724',791,'����� ���� ��',17,'���� ���� ','������','������ ��� ����� ���� ���� ������ ������ �-� ����','�����','������',495202,524914.12,524914.12,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17950424','05-06-2024','729871/5',795,'����� ���� ��������',26,'������ ����������','��� ����  ','���� ���� ������� ����� ���� 04/24','���','������',12000,12720,12720,'��� ����"�','07-11-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17950424','05-06-2024','950930/6',795,'����� ���� ��������',26,'������ ����������','��� ����  ','�������� ����� ���� 04/24','���','������',4000,4240,4240,'��� ����"�','07-11-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17950424','05-07-2024','18',795,'����� ���� ��������',26,'������ ����������','����� �����  ','������ ��������� 04/24','���','������',12501,13251.06,13251.06,'��� ����"�','07-11-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17920524','05-08-2024','47',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� �������� ��� 24','�����','������',579,613.74,613.74,'��� ����"�','07-16-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17950524','05-08-2024','02/001119',795,'����� ���� ��������',26,'������ ����������',' ������� �.�               ','����� �������� ���� ���� �������� ','���','������',3150,3339,3339,'��� ����"�','09-25-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-102','19630324','05-08-2024','19630324',963,'���� ������',37,'����"�','����','����� ����� 03/24','����','������',55000,57750,57750,'��� ����"�','05-22-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','19610324','05-08-2024','19610324',961,'���� ������',34,'�����','����','����� ����� 03/24','����','������',674545.89,708273.1845,708273.1845,'��� ����"�','05-22-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-102','14450424','05-12-2024','14550424',795,'����� ���� ��������',24,'���� ��������','����','����� ���� �������� ����� 2024','����','������',3380,3582.8,3582.8,'��� ����"�','05-28-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-408','17910424','05-12-2024','500217',790,'����� �����',1,'����� �����','���� ���� ��"�  ','����','����','������',6750,7155,7155,'��� ����"�','06-23-2024','��','���� ������',NULL,NULL,2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����',NULL,'17910824','08-15-2024','14824',791,'����� ���� ��',17,'���� ���� ','������','���� ���� ������� ��� ����� ����� ���� ������� ����� ������ 24','�����','������',95976,101734.56,101734.56,'���� �����','08-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17940524','05-16-2024','41',794,'���� ������',38,'������������','����� ��������  ','����� ������������� ����� ��� 2024','���','������',112502,119252.12,119252.12,'��� ����"�','07-11-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17940524','05-16-2024','42',794,'���� ������',38,'������������','����� ��������  ','����� ������������� ����� ����� 2024','���','������',107477,113925.62,113925.62,'��� ����"�','07-11-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-23-408','4450224','03-20-2024','4450224',795,'����� ���� ��������',24,'���� ��������','����','��� ������ ���� �������� ������ 2024','����','���',77753,82418.18,82418.18,'��� ����"�','04-16-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-24-160','7870424','05-16-2024','7870424',787,'����� �������',5,'��� ���� ����� ������ ������ ','����','��� ������ ����� 2023','����','���',18507.5471698113,19618,19618,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-23-408','7950424','05-16-2024','7950224',795,'����� ���� ��������',21,'��� ���� �����','����','��� ������ ����� 2024','����','���',20537.7358490566,21770,0,'��� ����"�','07-16-2024',NULL,'��',NULL,NULL,2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-160','7940424','05-16-2024','7940424',794,'���� ������',33,'��� ��� ������','����','��� ������ ����� 2024','����','���',68429.2452830189,72535,72535,'��� ����"�','07-10-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-160','7930424','05-16-2024','7930424',793,'����� ���� ��������',25,'������� ','����','��� ������ ����� 2024','����','���',109708.386792453,116290.89,75331,'��� ����"�','07-11-2024','������� ������� ����','���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-227','7920424','05-16-2024','7920424',792,'����� ���� ������ �����',29,'����� ����','����','��� ������ ����� 2024','����','���',861760.849056604,913466.5,913466.5,'��� ����"�','09-25-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-160','7900424','05-16-2024','790424',790,'����� �����',1,'����� �����','����','��� ������ ����� 2024','����','���',111858.490566038,118570,17556,'��� ����"�','07-11-2024','��� �� ��� ����','���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-160','7850324','05-16-2024','7850324',787,'����� �������',6,'����� ����� ������ ����� ������ �������','����','��� ������ ��� 2024','����','���',59176.4150943396,62727,62727,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-160','7850424','05-16-2024','7850424',787,'����� �������',6,'����� ����� ������ ����� ������ �������','����','��� ������ ����� 2024','����','���',56423.5849056604,59809,59809,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����',NULL,'17930824','08-27-2024','260824',793,'����� ���� ��������',25,'������� ������� ','������','���� ��������� ������ �������','���','������',78700,83422,83422,'���� �����','08-27-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17910524','05-28-2024','22524',791,'����� ���� ��',17,'���� ����','������� �����  ','����� ��������','����','������',486,515.16,515.16,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17910524','05-28-2024','21524',791,'����� ���� ��',17,'���� ����','������� �����  ','����� ��������','����','������',486,515.16,515.16,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17910524','05-28-2024','20524',791,'����� ���� ��',17,'���� ����','������� �����  ','����� ��������','����','������',459.8,487.388,487.388,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17910524','05-28-2024','18524',791,'����� ���� ��',17,'���� ����','������� �����  ','����� ��������','����','������',463,490.78,490.78,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17910524','05-28-2024','13524',791,'����� ���� ��',17,'���� ����','������� �����  ','����� ��������','����','������',462.7,490.462,490.462,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17910524','05-28-2024','11524',791,'����� ���� ��',17,'���� ����','������� �����  ','����� ��������','����','������',451.5,478.59,478.59,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17910524','05-28-2024','80524',791,'����� ���� ��',17,'���� ����','������� �����  ','����� ��������','����','������',481.6,510.496,510.496,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17910524','05-28-2024','60524',791,'����� ���� ��',17,'���� ����','������� �����  ','����� ��������','����','������',462.5,490.25,490.25,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930524','05-28-2024','30424',793,'����� ���� ��������',25,'������� �������� ���� �����','������ ����������  ','����� ������ �����-��� 2024','����','���',5000,5300,0,'��� ����"�','06-30-2024',NULL,'��',NULL,NULL,2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����',NULL,'17920824','08-27-2024','1683',792,'����� ���� ������ �����',30,'�������','������� �������','ODT ������� �������  ','����','������',42000,44520,44520,'���� �����','08-27-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'17920824','09-02-2024','1682',792,'����� ���� ������ �����',30,'�������','������� �������','����� ����� ������� ���� ','����','������',35000,37100,37100,'���� �����','09-02-2024',NULL,'���� ������','�� ','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930524','05-28-2024','1933',793,'����� ���� ��������',25,'������� �������','����� ���������  ','���� ������� ','���','������',1673,1773.38,1773.38,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930524','05-28-2024','38',793,'����� ���� ��������',25,'�������� ��������  �������','����� ������','����� ����� ���������  ����� ������ ','����','������',14215.5,15068.43,15068.43,'��� ����"�','06-30-2024',NULL,'��',NULL,NULL,2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930524','05-28-2024','43',793,'����� ���� ��������',25,'�������� ��������  �������','����� ������','���� ����� ����� �����','����','������',2340,2480.4,2480.4,'��� ����"�','06-30-2024',NULL,'��',NULL,NULL,2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930524','05-28-2024','400052',793,'����� ���� ��������',25,'������� �������',' ����� ��"�                ','����� �������� ','���','������',486,515.16,515.16,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930524','05-28-2024','1307',793,'����� ���� ��������',25,'������� �������',' ����� ���� ����           ','���� ����� ','���','������',28,29.68,29.68,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930624','07-01-2024','49',793,'����� ���� ��������',25,'�������� ��������  �������','����� ������','���� ����� ��������� �������� ����� ������ ����','����','������',2340,2480.4,2480.4,'��� ����"�','08-04-2024',NULL,'��',NULL,NULL,2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-18-2024','51',793,'����� ���� ��������',25,'�������� ��������  �������','����� ������','����� ����� ���������  ����� ������ ','����','������',14215.5,15068.43,15068.43,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17910524','05-28-2024','40068',791,'����� ���� ��',12,'������� ���� ���� ��������','������  ','������ ������� ����� ����� ����� ��� 24','����','���',23400,24804,24804,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17870524','05-28-2024','50020',787,'����� �������',5,'��� ������ ','����� �������  ','���� ������ ','���� ','������',8800,9328,9328,'��� ����"�','07-07-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17870524','05-28-2024','50021',787,'����� �������',5,'��� ������ ','����� �������  ','������ ����� ������ ����� ������ ','���� ','������',2000,2120,2120,'��� ����"�','07-07-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17870524','05-28-2024','IN244000339',787,'����� �������',3,'����� ������','������ ����  ','����� ��� ��� 04/24','����','������',87300,92538,92538,'��� ����"�','07-07-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17870524','05-28-2024','10071',787,'����� �������',3,'����� ������','�� �������  ','����� ������','����','������',5100,5406,5406,'��� ����"�','07-07-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','10-27-2024','3055',793,'����� ���� ��������',25,'������� �������','����� ������','����� ����� ���������  ����� ������ ','����','������',14215,15067.9,15067.9,'���� �����','10-27-2024',NULL,'��',NULL,NULL,2024,'���"�','10-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17870524','05-29-2024','IN244000443',787,'����� �������',3,'����� ������','������ ����  ','������ ��� ��� 05/24','����','������',152100,161226,161226,'��� ����"�','07-07-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17910524','05-30-2024','11027',791,'����� ���� ��',12,'������� ���� ���� ��������','��� ������  ','���� ������ ������ ����� ��� ��� 24 ','�����','������',38638.59,40956.9054,40956.9054,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17870524','05-30-2024','11028',787,'����� �������',3,'����� ������','��� ������  ','���� ����� ���� ��� 24','�����','������',12870,13642.2,13642.2,'��� ����"�','07-07-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17920524','05-30-2024','48',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� �������� ��� 24 ','�����','������',702,744.12,744.12,'��� ����"�','07-16-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17920524','05-30-2024','49',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� �������� ��� 24 ','�����','������',661.5,701.19,701.19,'��� ����"�','07-16-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17920524','05-30-2024','50',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� �������� ��� 24 ','�����','������',737,781.22,781.22,'��� ����"�','07-16-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17940324','04-04-2024','227',794,'���� ������',33,'��� ��� ������','������� �������','������ ��� ��� ���� +���� ���� ','���','������',2600,2756,2756,'��� ����"�','05-28-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-0005','1512','05-30-2024','1512',787,'����� �������',18,'�����',' ������ �����              ','�����  �����  ���� ��� �.������� ����� ��������','����','������',90360,90360,90360,'��� ����"�','07-21-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-0005','1532','05-30-2024','1532',787,'����� �������',18,'�����',' ������ �����              ','������ ������ ����� ���� ��� ����� �������� ','����','������',68040,68040,68040,'��� ����"�','07-21-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17910524','05-30-2024','23524',791,'����� ���� ��',17,'���� ���� ','������� �����  ','����� �������� ','����','������',491,520.46,520.46,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-102','1790524','06-04-2024','92',790,'����� �����',1,'����� �����','���� �������  ','����','����','���',1800,1908,1908,'��� ����"�','07-14-2024',NULL,'��',NULL,NULL,2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17930424','05-02-2024','08/117697',793,'����� ���� ��������',25,'������� �������','����','������ �������� ���� ����� ','���','������',69.5,73.67,73.67,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930624','07-01-2024','08/134114',793,'����� ���� ��������',25,'������� �������','����','��� ','���','������',64.5,68.37,68.37,'��� ����"�','08-04-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-23-408','7910424','06-04-2024','7910424',791,'����� ���� ��',17,'���� ���� ','����','��� ����� ���� ���� ����� 24','����','���',11240.7,11915.142,11915.142,'��� ����"�','07-16-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17940524','06-04-2024','43',794,'���� ������',38,'������������','����� ��������  ','����� ������������� ����� ��� 2024','���','������',159841,169431.46,169431.46,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17950524','06-04-2024','950930/7',795,'����� ���� ��������',26,'������ ����������','��� ����  ','�������� ����� ���� ��� 24','���','������',16000,16960,16960,'��� ����"�','09-25-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17950524','06-04-2024','729871/6',795,'����� ���� ��������',26,'������ ����������','��� ����  ','���� ���� �������� ����� ���� ��� 24','���','������',8000,8480,8480,'��� ����"�','09-25-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17950524','06-04-2024','641407/5',795,'����� ���� ��������',26,'������ ����������','��� ����  ','���� ���� ����� ���� ������ ��� 24','���','������',32000,33920,33920,'��� ����"�','09-25-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-11-2024','IN244000091',793,'����� ���� ��������',25,'������� �������','������','����� ������ �� �������� �����','���','������',33740,35764.4,35764.4,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-08-2024','40024',793,'����� ���� ��������',25,'������� �������','������� �������','����� ����� ������� ������� ����� ','���','������',4998,5297.88,5297.88,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930624','06-06-2024','IN240000619',793,'����� ���� ��������',25,'������� �������','����� ���  ','���� ������� ������� ��� 24','���','������',1288,1365.28,1365.28,'��� ����"�','08-04-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-227','7920524','06-06-2024','7920524',792,'����� ���� ������ �����',29,'����� ����','����','��� ������ ��� 2024','����','���',867991.509433962,920071,920071,'��� ����"�','10-27-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-23-408','7910524','06-06-2024','7910524',791,'����� ���� ��',17,'���� ���� ','����','��� ����� ���� ���� ��� 24','����','���',11240.5660377358,11915,11915,'��� ����"�','07-07-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','7870524','06-06-2024','7870524',787,'����� �������',5,'��� ���� ����� ������ ������ ','����','��� ������ ��� 24','����','���',15896.2264150943,16850,16850,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','790524','06-06-2024','790524',790,'����� �����',1,'����� �����','����','��� ������ ��� 24','����','���',117905.283018868,124979.6,17263.8,'��� ����"�','07-21-2024','������ �� ��� ����','���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','7930524','06-06-2024','7930524',793,'����� ���� ��������',25,'������� ','����','��� ������ ��� 24','����','���',115093.839622642,121999.47,83419,'��� ����"�','06-06-2024','������� ������� ����','���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','7940524','06-06-2024','7950424',794,'���� ������',33,'��� ��� ������','����','��� ������ ��� 24','����','���',70587.7358490566,74823,74823,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','7950524','06-06-2024','79504024',795,'����� ���� ��������',21,'��� ���� �����','����','��� ������ ��� 24','����','���',16386.7924528302,17370,0,'��� ����"�','07-07-2024',NULL,'��',NULL,NULL,2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17950524','06-10-2024','10025',795,'����� ���� ��������',26,'������ ����������','����� ������  ','������ �������� ��� 24','���','������',478383,507085.98,507085.98,'��� ����"�','09-25-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-0005','1579','06-10-2024','1579',787,'����� �������',5,'�����',' ������ �����              ','�����  ��� ��� �.������� ����� ������� ','����','������',158400,158400,158400,'��� ����"�','07-07-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17870624','06-10-2024','1581',787,'����� �������',5,'����',' ������ �����              ','�����  ���� ��� ��� �.������� ����� �������','���� ','������',25600,27136,27136,'��� ����"�','07-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('������','36-24-0011','90030065','06-10-2024','90030065',NULL,'����� ���� ��������',19,'������ �������� ',' ���������� �������       ','����� ������ ���"�','����','������',0,354900,354900,'��� ����"�','07-21-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17950524','06-10-2024','26',795,'����� ���� ��������',26,'������ ����������','����� �����  ','������ ��������� ��� 24','���','������',68235.26,72329.3756,72329.3756,'��� ����"�','09-25-2024',NULL,'���� ������','�� ','06-13-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('������','36-24-0004','2024-02','06-13-2024','2024-02',NULL,'����� �������',5,'�����','������ �����  ','�����  ����� �� ��� 24','����','������',183501,183501,183501,'��� ����"�','07-21-2024',NULL,'���� ������','�� ','06-13-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910324','03-21-2024','90024',791,'����� ���� ��',17,'���� ���� ','�����','���� ����� ������ ������ 2024','�����','������',26853.8,28465.028,28465.028,'��� ����"�','05-02-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910624','06-16-2024','233000038',791,'����� ���� ��',16,'�� �������� ������ ����� ','�������� ��"�  ','���� ��������� �� ����� ����� ������ - ����� ��� ����','����','������',38142,40430.52,40430.52,'��� ����"�','09-15-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930624','06-23-2024','942',793,'����� ���� ��������',25,'������� �������',' ��� �����                 ','����� �� ����� �������� ','���','������',3680,3900.8,3900.8,'��� ����"�','08-04-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-23-325','57900923','07-04-2024','3169',790,'����� �����',1,'����� �����','��� ��������  ','��� ������ 2023','����','���',41535,44027.1,0,'��� ����"�','06-24-2024',NULL,'��',NULL,NULL,2024,'���"�','09-2023')
 INSERT [Invoices] VALUES('����','36-23-366','57901023','07-04-2024','3171',790,'����� �����',1,'����� �����','��� ��������  ','��� ������� 2023','����','���',41535,44027.1,0,'��� ����"�','06-25-2024',NULL,'��',NULL,NULL,2024,'���"�','10-2023')
 INSERT [Invoices] VALUES('����','36-23-408','57901123','07-04-2024','3175',790,'����� �����',1,'����� �����','��� ��������  ','��� ������ 2023','����','���',41535,44027.1,0,'��� ����"�','06-26-2024',NULL,'��',NULL,NULL,2024,'���"�','11-2023')
 INSERT [Invoices] VALUES('����',NULL,'57900424','05-09-2024','3188',790,'����� �����',1,'����� �����','��� ��������  ','��� ����� 2024','����','���',41535,44027.1,0,'���� �����','06-27-2024',NULL,'��',NULL,NULL,2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����',NULL,'57900524','06-05-2024','2000',790,'����� �����',1,'����� �����','��� ��������  ','��� ���  2024','����','���',41535,44027.1,0,'���� �����','06-28-2024',NULL,'��',NULL,NULL,2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17940624','06-23-2024','1503',794,'���� ������',33,'��� ��� ������',' ���� ������               ','������ ���� ���� ��"� ���� ','���','������',10000,10600,10600,'��� ����"�','09-15-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910324','03-31-2024','90025',791,'����� ���� ��',17,'���� ���� ','�����','���� ����� ������ ���  2024','�����','������',45227.5,47941.15,47941.15,'��� ����"�','05-02-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17920624','06-27-2024','10073',792,'����� ���� ������ �����',29,'����� ����','�� �������  ','����� ������','����','������',1800,1908,1908,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-160','4450424','06-30-2024','4450424',795,'����� ���� ��������',24,'���� ��������','����','��� ������ ���� �������� ����� 24','����','���',51111,54177.66,54177.66,'��� ����"�','07-10-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-160','4450524','06-30-2024','4450524',795,'����� ���� ��������',24,'���� ��������','����','��� ������ ���� �������� ��� 24','����','���',69078,73222.68,73222.68,'��� ����"�','07-10-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','14450524','06-30-2024','14450524',795,'����� ���� ��������',24,'���� ��������','����','�����  ���� �������� ��� 24','����','������',28317.5,30016.55,30016.55,'��� ����"�','07-10-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','19610424','06-30-2024','17910424',961,'���� ������',34,'�����','����','����� ����� 04/24','����','������',111450,117022.5,117022.5,'��� ����"�','07-07-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-160','19610524','06-30-2024','19610524',961,'���� ������',34,'�����','����','����� ����� 05/24','����','������',555479,583252.95,583252.95,'��� ����"�','07-07-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','9610424','06-30-2024','9610424',961,'���� ������',34,'�����','����','��� ������ ����� 04/24','����','���',22404.6,23524.83,23524.83,'��� ����"�','07-07-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-160','9610524','06-30-2024','9610524',961,'���� ������',34,'����� ','����','��� ������ ����� 05/24','����','���',43982,46181.1,46181.1,'��� ����"�','07-07-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','9660424','06-30-2024','9660424',966,'���� ������',34,'����������','����','��� ������ ��������� ����� 2024 ','����','���',3803.6,3993.78,3993.78,'��� ����"�','07-07-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-160','9660524','06-30-2024','9660524',966,'���� ������',34,'����������','����','��� ������ ��������� ��� 2024 ','����','���',7664.7,8047.935,8047.935,'��� ����"�','07-07-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','19660524','06-30-2024','19660524',966,'���� ������',34,'����������','����','����� ����� �������� 05/24','����','������',17760,18648,18648,'��� ����"�','07-07-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','9630424','06-30-2024','9630424',963,'���� ������',37,'����"�','����','��� ���"�� 04/24','����','���',221179,232237.95,232237.95,'��� ����"�','07-07-2024',NULL,'���� ������','��','06-16-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-160','9630524','06-30-2024','9630524',963,'���� ������',37,'����"�','����','��� ���"�� 05/24','����','���',247716.9,260102.745,260102.745,'��� ����"�','09-08-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','19630524','06-30-2024','19630524',963,'���� ������',37,'����"�','����','����� ����� 05/24','����','������',59990,62989.5,62989.5,'��� ����"�','07-07-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17910424','04-30-2024','90026',791,'����� ���� ��',17,'���� ���� ','�����','���� ����� �������� ����� 24','�����','������',22613.76,23970.5856,23970.5856,'��� ����"�','06-10-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17950624','07-01-2024','729871/7',795,'����� ���� ��������',26,'������ ����������','��� ����  ','���� ���� -������� ����  ���� 24','���','������',28000,29680,29680,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17950624','07-01-2024','641407/6',795,'����� ���� ��������',26,'������ ����������','��� ����  ','���� ���� - ����� ������ ���� ������  ���� 24','���','������',24000,25440,25440,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17950624','07-01-2024','950930/8',795,'����� ���� ��������',26,'������ ����������','��� ����  ','�������� -����� ���� ���� 24','���','������',24000,25440,25440,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17910524','05-30-2024','90027',791,'����� ���� ��',17,'���� ����','�����','���� ����� �������� ��� 24','�����','������',39574.08,41948.5248,41948.5248,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930624','07-01-2024','2874',793,'����� ���� ��������',25,'������� �������','���� ����� ��"�  ','����� �������� ','���','������',319,338.14,338.14,'��� ����"�','08-04-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930624','07-01-2024','8170867',793,'����� ���� ��������',25,'������� �������',' ������ ����               ','���� ','���','������',123,130.38,130.38,'��� ����"�','08-04-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910724','08-05-2024','90028',791,'����� ���� ��',17,'���� ���� ','�����','���� ����� ���� ','����','������',14133.6,14981.616,14981.616,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','09-29-2024','12493',791,'����� ���� ��',14,'����� ������ ','����','����� ������ ����� ','����� ','������',626,663.56,663.56,'���� �����','09-29-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','09-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17950324','04-01-2024','10023',795,'����� ���� ��������',26,'������ ����������','������','����� ������ ������ ���������� ���� 03/24','���','������',98566.67,104480.6702,104480.6702,'��� ����"�','05-12-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910624','07-01-2024','724',791,'����� ���� ��',17,'���� ���� ','���� ��"�  ','������ ��� ����� ','����','������',7000,7420,7420,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910624','07-01-2024','734',791,'����� ���� ��',17,'���� ���� ','���� ��"�  ','������ ��� ����� ','����','������',7000,7420,7420,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17950424','05-06-2024','10024',795,'����� ���� ��������',26,'������ ����������','������','����� ������ ������ ���������� ���� 04/24','���','������',229513,243283.78,243283.78,'��� ����"�','07-11-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17950624','07-01-2024','10027',795,'����� ���� ��������',26,'������ ����������','������','����� ������ ������ ��������� ���� 24 ','���','������',246889.5,261702.87,261702.87,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-30-2024','183',793,'����� ���� ��������',25,'�������� ��������  �������','�����','����� �������','����','������',4500,4770,4770,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-30-2024','184',793,'����� ���� ��������',25,'�������� ��������  �������','�����','����� �������','����','������',4000,4240,4240,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910624','07-02-2024','2024-510486',791,'����� ���� ��',17,'���� ���� ','������� �����  ','���  �������� ','����','������',497.5,527.35,527.35,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910624','07-03-2024','2024-539707',791,'����� ���� ��',17,'���� ���� ','������� �����  ','���� ����� ���� ','����','������',422.8,448.168,448.168,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910624','07-04-2024','2024-539741',791,'����� ���� ��',17,'���� ���� ','������� �����  ','����� ���� ���� ','����','������',1100,1166,1166,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910624','07-05-2024','2024-543612',791,'����� ���� ��',17,'���� ���� ','������� �����  ','����� ���� ���� ','����','������',1100,1166,1166,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910624','07-06-2024','2024-543709',791,'����� ���� ��',17,'���� ���� ','������� �����  ','����� ����� ��� ����� ','����','������',500,530,530,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17920624','07-04-2024','1715',792,'����� ���� ������ �����',30,'�������','������� �������','���� ����� ������� 7/24','�����','������',5500,5830,5830,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'17920824','08-27-2024','22',792,'����� ���� ������ �����',30,'�������','��� ','����� ����� ������ ','����','������',11200,11872,11872,'���� �����','08-27-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17910224','02-25-2024','24/00006909',791,'����� ���� ��',17,'���� ���� ','����','������ ����� ���� ','����','������',120,127.2,127.2,'��� ����"�','04-04-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17930424','04-02-2024','40292',793,'����� ���� ��������',25,'������� �������� ���� �����','������ �����  ','����� ������� ������� �����- ������ 24','����','������',19305,20463.3,0,'��� ����"�','06-30-2024',NULL,'��',NULL,NULL,2024,'���"�','02-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17870624','07-01-2024','IN244000519',787,'����� �������',3,'����� ������','������ ����  ','����� ��� ��� 06/24','����','������',140700,149142,149142,'��� ����"�','07-30-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910624','07-01-2024','60132',791,'����� ���� ��',12,'������� ���� ���� ��������','������  ','������ ������� ����� ����� ����� ���� 24','����','���',23400,24804,24804,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910624','07-01-2024','5580',791,'����� ���� ��',17,'���� ���� ','���� �������  ','�� ����� ����� ������ ','����','������',7000,7420,7420,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('������','36-24-0060','90030385','07-01-2024','90030385',NULL,'����� ���� ��',5,'��� ���� ',' ���������� �������       ','����� ���"�','����','������',33600,33600,33600,'��� ����"�','08-04-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����',NULL,'7920624','07-02-2024','7920624',792,'����� ���� ������ �����',29,'����� ����','����','��� ������ ���� 24','����','���',1262362,1338103.72,1338103.72,'���� �����','07-02-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','7910624','07-02-2024','7910624',791,'����� ���� ��',17,'���� ���� ','����','��� ����� ���� 24','����','���',16984.7,18003.782,18003.782,'��� ����"�','09-12-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','7930624','07-02-2024','7930624',793,'����� ���� ��������',25,'������� ','����','��� ������ ���� 24','����','���',170107,180313.42,127697,'��� ����"�','09-25-2024','������� ������� ����','���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','7870624','07-02-2024','7870624',787,'����� �������',5,'��� ���� ����� ������ ������ ','����','��� ������ ���� 24','����','���',17989,19068.34,19068.34,'��� ����"�','09-12-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','7940624','07-02-2024','7940624',794,'���� ������',33,'��� ��� ������','����','��� ������ ���� 24','����','���',94368.49,100030.5994,100030.5994,'��� ����"�','09-12-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','7950624','07-02-2024','7950624',795,'����� ���� ��������',21,'��� ���� �����','����','��� ������ ���� 24 ','����','���',15586.36,16521.5416,0,'��� ����"�','09-12-2024',NULL,'��',NULL,NULL,2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','7900624','07-02-2024','790624',790,'����� �����',1,'����� �����','����','��� ������ ���� 24 ','����','���',172304.8,182643.088,23186.07,'��� ����"�','10-27-2024','��� ��� ����','���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17900624','07-04-2024','30000',790,'����� �����',1,'����� �����','���� �������  ','����','����','���',900,954,0,'��� ����"�','08-18-2024',NULL,'��',NULL,NULL,2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17930424','05-05-2024','40304',793,'����� ���� ��������',25,'������� �������� ���� �����','������ �����  ','����� ������� ������� ���  24 ','����','������',6435,6821.1,0,'��� ����"�','06-30-2024',NULL,'��',NULL,NULL,2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����',NULL,'57900624','07-04-2024','2001',790,'����� �����',1,'����� �����','��� ��������  ','��� ���� 24','����','���',41535,44027.1,0,'���� �����','07-04-2024',NULL,'��',NULL,NULL,2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17920624','07-04-2024','57',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� �������� ','�����','������',936,992.16,992.16,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17920624','07-04-2024','56',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� �������� ','�����','������',643,681.58,681.58,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17920624','07-04-2024','55',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� �������� ','�����','������',532,563.92,563.92,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17920624','07-04-2024','53',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� �������� ','�����','������',468,496.08,496.08,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17920624','07-04-2024','54',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� �������� ','�����','������',234,248.04,248.04,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17920624','07-04-2024','51',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� �������� ','�����','������',702,744.12,744.12,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17920624','07-04-2024','52',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� �������� ','�����','������',748,792.88,792.88,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17930524','05-09-2024','40307',793,'����� ���� ��������',25,'������� ���� ����� ','������ �����  ','����� ������� �����','����','������',6435,6821.1,6821.1,'��� ����"�','05-22-2024','��','���� ������',NULL,NULL,2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17930424','05-12-2024','40307',793,'����� ���� ��������',25,'������� �������� ���� �����','������ �����  ','����� ������� ������� ����� 24 ','����','������',6435,6821.1,0,'��� ����"�','06-30-2024',NULL,'��',NULL,NULL,2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17920624','07-04-2024','2072024',792,'����� ���� ������ �����',30,'�������','���� ������  ','����� ���������� ���� ����� �������� 6/24','�����','������',8000,8480,8480,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-160','14450624','07-07-2024','14450624',795,'����� ���� ��������',24,'���� ��������','����','����� ���� �������� ���� 24','����','������',7260,7695.6,7695.6,'��� ����"�','07-30-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-160','4450624','07-07-2024','4450624',795,'����� ���� ��������',24,'���� ��������','����','��� ������ ���� 24','����','���',67765.6,71831.536,71831.536,'��� ����"�','07-10-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17900624','07-08-2024','500221',790,'����� �����',1,'����� �����','���� �������  ','����','����','������',6750,7155,0,'��� ����"�','08-18-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17940624','07-08-2024','44',794,'���� ������',38,'������������','����� ��������  ','����� ������������� ����� ���� 2024','���','������',105888,112241.28,112241.28,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930624','06-06-2024','40314',793,'����� ���� ��������',25,'������� �������� ���� �����','������ �����  ','���� �������� ����� ������ ������� 5/24','����','������',1200,1272,0,'��� ����"�','08-04-2024',NULL,'��',NULL,NULL,2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930624','06-06-2024','40313',793,'����� ���� ��������',25,'������� �������� ���� �����','������ �����  ','����� ������� ������� ������ ��� 24','����','������',6435,6821.1,0,'��� ����"�','08-04-2024',NULL,'��',NULL,NULL,2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-18-2024','40322',793,'����� ���� ��������',25,'������� �������� ���� �����','������ �����  ','����� ������� ������� ���� ','����','������',6435,6821.1,0,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'17950824','07-15-2024','10028',795,'����� ���� ��������',26,'������ ����������','����� ������  ','����� ������ ������ �������� ���� 24','���','������',10983,11641.98,11641.98,'���� �����','07-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17870724','07-16-2024','16724',787,'����� �������',5,'������ ���� ','������ �����  ','�����  ���� ','���� ','������',32160,34089.6,34089.6,'��� ����"�','10-14-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17940724','07-17-2024','45',794,'���� ������',38,'������������','����� ��������  ','����� ������������� ����� ���� 2024','���','������',23173,24563.38,24563.38,'��� ����"�','09-12-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','08-04-2024','40330',793,'����� ���� ��������',25,'������� �������� ���� �����','������ �����  ','����� ������� ������� ���� ','����','������',6435,6821.1,0,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'17920824','07-18-2024','58',792,'����� ���� ������ �����',30,'�������','��� ����  ','���� ������� ���� 24','�����','������',550,583,583,'���� �����','07-18-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'17930924','09-22-2024','40340',793,'����� ���� ��������',25,'������� �������� ���� �����','������ �����  ','����� ������� ������� ������  ','����','������',6435,6821.1,0,'���� �����','09-22-2024',NULL,'��',NULL,NULL,2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17930424','05-02-2024','10517970',793,'����� ���� ��������',25,'������� �������',' ������� ������           ','�� ���� ������ ���� ����� ','���','������',90.4,95.824,95.824,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17930224','02-29-2024','40002',793,'����� ���� ��������',25,'������� �������','���� ����  ','���� ����� ����� �������� �����-������ 2024','��','������',46800,49608,49608,'��� ����"�','04-14-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930524','05-28-2024','40004',793,'����� ���� ��������',25,'������� �������','���� ����  ','������ ����� ���-��� ','��','������',53235,56429.1,56429.1,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930624','06-13-2024','40005',793,'����� ���� ��������',25,'������� �������','���� ����  ','������ ����� ����','��','������',4095,4340.7,4340.7,'��� ����"�','08-04-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-21-2024','40007',793,'����� ���� ��������',25,'������� �������','���� ����  ','���� ��� ����� ������� ','��','������',53703,56925.18,56925.18,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17870724','07-21-2024','50031',787,'����� �������',5,'��� ������ ','����� �������  ','����� ��� ������� ������� ����� ','����','������',16000,16960,16960,'��� ����"�','10-14-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17870724','07-21-2024','50032',787,'����� �������',5,'��� ������ ','����� �������  ','����� ���, ���� ����,����� ����, ����� ����� ','����','������',10013,10613.78,10613.78,'��� ����"�','10-14-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17930324','03-26-2024','450',793,'����� ���� ��������',25,'������� �������','���� ���� ��"�  ','������ ����� ����� �������� ','���','������',1800,1908,1908,'��� ����"�','05-12-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17930424','04-03-2024','467',793,'����� ���� ��������',25,'������� �������','���� ���� ��"�  ','������ O.D.T  ����� ����� ������ 4/24','���','������',7605,8061.3,8061.3,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-101','2197','07-21-2024','2197',793,'����� ���� ��������',25,'������� �������','����� ���������  ','����� ������� ����� ������� ����� ����� ���� ','���','������',0,191814,191814,'��� ����"�','08-04-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'17950824','07-21-2024','210724',795,'����� ���� ��������',20,'������ ������ ','������ �����  ','������ ������ ���� �� ���� 2024 ','����','������',58650,62169,62169,'���� �����','07-21-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'7940624','07-22-2024','7940624',794,'���� ������',33,'��� ��� ������','����','��� ������ ���� 24','����','���',94368.49,100030.5994,100030.5994,'��� ����"�','10-09-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','7850624','07-22-2024','7850624',787,'����� �������',6,'����� ����� ������ ����� ������ �������','����','��� ������ ���� 24 ','����','���',72192.09,76523.6154,76523.6154,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17870724','07-23-2024','PI24000008',787,'����� �������',11,'���� ������','���� ���  ','���� ������ �������� �����  2/2','����','������',150000,159000,159000,'��� ����"�','10-14-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17870724','07-23-2024','PI24000006',787,'����� �������',11,'���� �����','���� ���  ','���� ����� ����� 2/2','����','������',150000,159000,159000,'��� ����"�','10-14-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17870724','07-23-2024','PI24000007',787,'����� �������',3,'����� ������','���� ���  ','����� ��� ��� ���� ','����','������',200000,212000,212000,'��� ����"�','10-14-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'9610624','07-23-2024','960624',961,'���� ������',34,'����� ','����','��� ������ ����� 06/24','����','���',42303.8,44418.99,44418.99,'���� �����','10-07-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����',NULL,'9660624','07-23-2024','9660624',966,'���� ������',34,'����������','����','��� ������ ��������� ���� 24','����','���',12539,13165.95,13165.95,'���� �����','10-07-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','19610624','07-23-2024','19610624',961,'���� ������',34,'�����','����','����� ����� 06/24','����','������',495945.7,520742.985,520742.985,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','19660624','07-23-2024','19660624',966,'���� ������',34,'����������','����','����� ����� �������� 06/24','����','������',8447.5,8869.875,8869.875,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('������','36-24-0071','90030855','07-23-2024','90030855',NULL,'����� ���� ��������',25,'������� �������',' ���������� �������       ','����� �������  ����� � ����','���','������',0,233827,233827,'��� ����"�','11-12-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-100','2196','07-24-2024','2196',795,'����� ���� ��������',25,'������� ������� ','����� ���������  ','����� ��"� ����� ��� ��� ��� ','���','������',0,13263,13263,'�������','08-04-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'17910824','09-02-2024','359318',791,'����� ���� ��',17,'���� ���� ','���� �����','����� ����� ���� ','����','������',446,472.76,472.76,'���� �����','09-02-2024',NULL,'���� ������','�� ','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'17910924','10-01-2024','20012',791,'����� ���� ��',14,'����� ������ ','����','���� ����� ������  09/24','����� ','���',14040,14882.4,14882.4,'���� �����','10-01-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','09-2024')
 INSERT [Invoices] VALUES('������','36-24-0011','90030910','07-28-2024','90030910',NULL,'����� ���� ��������',19,'������ �������� ',' ���������� �������       ','��������� ����� ����� �����','����','������',0,46200,46200,'��� ����"�','08-20-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-29-2024','2295',793,'����� ���� ��������',25,'������� �������','����� ���������  ','������ �������� ����� ������� ','���','������',7289,7726.34,7726.34,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-29-2024','2296',793,'����� ���� ��������',25,'������� �������','����� ���������  ','������ �������� ����� ������� ','���','������',1041,1103.46,1103.46,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-29-2024','983',793,'����� ���� ��������',25,'������� �������',' ��� �����                 ','������ ������ ������ ��� ���� ���� ','���','������',20000,21200,21200,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-29-2024','152',793,'����� ���� ��������',25,'������� �������','���� �������  ','������ , ����� , ������ ','���','������',150,159,159,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-29-2024','153',793,'����� ���� ��������',25,'������� �������','���� �������  ','������ ','���','������',110,116.6,116.6,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-29-2024','494',793,'����� ���� ��������',25,'������� �������','���� ���� ��"�  ','���� ����� ������� ','���','������',17433,18478.98,18478.98,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-29-2024','146',793,'����� ���� ��������',25,'������� �������','���� �������  ','������ , ����� , ������ ','���','������',148,156.88,156.88,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-29-2024','8172703',793,'����� ���� ��������',25,'������� �������',' ������ ����               ','����  ����� ','���','������',90,95.4,95.4,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-29-2024','8171482',793,'����� ���� ��������',25,'������� �������',' ������ ����               ','����  ����� ','���','������',61,64.66,64.66,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-29-2024','8172590',793,'����� ���� ��������',25,'������� �������',' ������ ����               ','����  ����� ','���','������',132,139.92,139.92,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','11-03-2024','20015',791,'����� ���� ��',14,'����� ������ ','����','���� ����� ������  10/24','����� ','���',8775,9301.5,9301.5,'���� �����','11-03-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','10-2024')
 INSERT [Invoices] VALUES('����',NULL,'17950824','07-18-2024','IN2408481',795,'����� ���� ��������',26,'������ ����������','�����','����� �� ����� ������ ��������� ��������� ','���','������',1966,2083.96,2083.96,'���� �����','07-18-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-102','17930424','05-02-2024','1339',793,'����� ���� ��������',25,'������� �������','����','����� ����� �������� 04/2024','���','������',6400,6784,6784,'��� ����"�','06-30-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910624','07-07-2024','39/3',791,'����� ���� ��',17,'���� ���� ','���','������� ���� ������ ���� ���� ','����','������',144,152.64,152.64,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910624','07-08-2024','40/1',791,'����� ���� ��',17,'���� ���� ','���','������� ���� ������ ���� ���� ','����','������',144,152.64,152.64,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910624','07-09-2024','40/2',791,'����� ���� ��',17,'���� ���� ','���','������� ���� ������ ���� ���� ','����','������',144,152.64,152.64,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-30-2024','250724',793,'����� ���� ��������',25,'�������� ��������  �������','����� �������  ','����� �������� ','����','������',50.85,53.901,53.901,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-30-2024','150823',793,'����� ���� ��������',25,'�������� ��������  �������','����� �������  ','����� �������� ','����','������',132,139.92,139.92,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-30-2024','90524',793,'����� ���� ��������',25,'�������� ��������  �������','����� �������  ','����� �������� ','����','������',56.7,60.102,60.102,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-30-2024','150823',793,'����� ���� ��������',25,'�������� ��������  �������','����� �������  ','����� �������� ','����','������',146.9,155.714,155.714,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910624','07-10-2024','40/4',791,'����� ���� ��',17,'���� ���� ','���','������� ���� ������ ���� ���� ','����','������',144,152.64,152.64,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17950124','02-06-2024','1316',795,'����� ���� ��������',26,'������ ����������','����� �����  ','������ ��������� ����� 2024','���','������',81269,86145.14,86145.14,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-30-2024','230524',793,'����� ���� ��������',25,'�������� ��������  �������','����� �������  ','����� �������� ','����','������',59,62.54,62.54,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17930124','01-21-2024','11002',793,'����� ���� ��������',25,'������� �������','���� ���������  ','���� �������� ','���','������',3640,3858.4,3858.4,'��� ����"�','03-10-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','12-2023')
 INSERT [Invoices] VALUES('����','36-23-408','17930324','03-21-2024','210324',793,'����� ���� ��������',25,'�������� ��������  �������','���� ���������  ','����� ����� 3/24','����','������',15000,15900,15900,'��� ����"�','05-12-2024',NULL,'��',NULL,NULL,2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����',NULL,'17930824','09-02-2024','180824',793,'����� ���� ��������',25,'������� �������','���� ���������  ','����� �������� ','����','������',1390,1473.4,1473.4,'���� �����','09-02-2024',NULL,'��',NULL,NULL,2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17950524','05-28-2024','249633',795,'����� ���� ��������',26,'������ ����������',' ����� ���                 ','���� ����� ��������� ','���','������',25974,27532.44,27532.44,'��� ����"�','09-25-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','04-2024')
 INSERT [Invoices] VALUES('����',NULL,'17920824','08-29-2024','527',792,'����� ���� ������ �����',30,'�������','�����','������ ��� ������� ������� ','����','������',44000,46640,46640,'���� �����','08-29-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-31-2024','240524',793,'����� ���� ��������',25,'������� �������� ���� �����','������ ����������  ','����� ������ ��� ���� ','����','������',5000,5300,0,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-31-2024','300624',793,'����� ���� ��������',25,'������� �������� ���� �����','������ ����������  ','����� ������ ���� ����','����','������',5000,5300,0,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','07-31-2024','500230',790,'����� �����',1,'����� �����','���� ���� ��"�  ','����','����','������',4500,4770,4770,'���� �����','07-31-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910724','08-01-2024','60135',791,'����� ���� ��',12,'������� ���� ���� ��������','������  ','������ ������� ����� ����� ����� ���� 24','����','���',23400,24804,24804,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','7950724','08-01-2024','7950724',795,'����� ���� ��������',21,'��� ���� �����','����','��� ������ ���� 24','����','���',5487,5816.22,0,'��� ����"�','10-14-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','7940724','08-01-2024','7940724',794,'���� ������',33,'��� ��� ������','����','��� ������ ���� 24','����','���',69955,74152.3,74152.3,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','7910724','08-01-2024','7910724',791,'����� ���� ��',17,'���� ���� ','����','��� ������ ���� 24','����','���',16102.69,17068.8514,17068.8514,'��� ����"�','10-27-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','7900724','08-01-2024','7900724',790,'����� �����',1,'����� �����','����','��� ������ ���� 24','����','���',121618,128915.08,17143.9,'��� ����"�','10-27-2024','��� ��� ����','���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','7870724','08-01-2024','7870724',787,'����� �������',5,'��� ���� ����� ������ ������ ','����','��� ������ ���� 24','����','���',19517.5,20688.55,20688.55,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'7920724','08-01-2024','7920724',792,'����� ���� ������ �����',29,'����� ����','����','��� ������ ���� 24','����','���',848905.8,899840.148,899840.148,'���� �����','08-01-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','7930724','08-01-2024','7930724',793,'����� ���� ��������',25,'������� ','����','��� ������ ���� 24','����','���',109173.8,115724.228,92617,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17870724','08-01-2024','IN244000589',787,'����� �������',3,'����� ������','������ ����  ','����� ��� ��� 7/24 ','����','������',70800,75048,75048,'��� ����"�','10-14-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-160','4450724','08-04-2024','4450724',795,'����� ���� ��������',24,'���� ��������','����','��� ������ ���� �������� ��� 24','����','���',14706,15588.36,15588.36,'��� ����"�','08-20-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'17910924','10-10-2024','1209229',791,'����� ���� ��',14,'����� ������ ','�����','����� ','����� ','������',115,121.9,121.9,'���� �����','10-14-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','09-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','09-18-2024','412',787,'����� �������',5,'��� ����� ','���� ��� ��"�  ','�����  8 ������ ','����','������',28800,30528,30528,'���� �����','09-18-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('������','36-23-405','007/2024','08-05-2024','2024/007',NULL,'����� �������',5,'�� ���� ','����� �����  ','����� ����� �� ���� 24','����','������',0,16960,16960,'��� ����"�','11-12-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910724','08-05-2024','3801',791,'����� ���� ��',17,'���� ���� ','������� �����  ','����� ','����','������',368,390.08,390.08,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','08-15-2024','30002',790,'����� �����',1,'����� �����','���� �������  ','������  08/24','����','������',900,954,0,'���� �����','08-15-2024',NULL,'��',NULL,NULL,2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','09-18-2024','411',787,'����� �������',5,'������','���� ��� ��"�  ','�����  8 ������ ����� �������','����','������',33600,35616,35616,'���� �����','09-18-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����','36-23-408','17930124','01-23-2024','3672',793,'����� ���� ��������',25,'������� �������','���� �������  ','��� ������ ����� ','���','������',100,106,106,'��� ����"�','05-02-2024',NULL,'���� ������','��','03-30-2024',2024,'���"�','01-2024')
 INSERT [Invoices] VALUES('����',NULL,'17870824','08-22-2024','11170',787,'����� �������',3,'����� ������','��� ������  ','���� ����� ���� ������ 24','�����','������',1544,1636.64,1636.64,'���� �����','08-22-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2023')
 INSERT [Invoices] VALUES('����',NULL,'17870824','08-22-2024','10075',787,'����� �������',3,'����� ������','�� �������  ','����� ������','����','������',3000,3180,3180,'���� �����','08-22-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2023')
 INSERT [Invoices] VALUES('����','36-24-227','19630624','08-26-2024','19630624',963,'���� ������',37,'����"�','����','����� ����� 06/24','����','������',65670,68953.5,68953.5,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','19630724','08-26-2024','19630724',963,'���� ������',37,'����"�','����','����� ����� 07/24','����','������',748021.98,785423.079,785423.079,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'9630624','08-26-2024','9630624',963,'���� ������',37,'����"�','����','��� ����� ���� 2024','����','���',259578.06,272556.963,272556.963,'���� �����','08-26-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����',NULL,'9630724','08-26-2024','9630724',963,'���� ������',37,'����"�','����','��� ����� ���� 2024','����','���',214302.33,225017.4465,225017.4465,'���� �����','08-26-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'9610724','08-26-2024','9610724',961,'���� ������',34,'�����','����','��� ������ ����� 07/24','����','���',42374.81,44493.5505,44493.5505,'���� �����','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','9660724','08-26-2024','9660724',966,'���� ������',34,'����������','����','��� ������ ��������� ���� 24','����','���',1800.4,1890.42,1890.42,'��� ����"�','10-27-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'17920824','08-26-2024','2877',792,'����� ���� ������ �����',30,'�������','���� ����� ��"�  ','����� �������� ���� 24','�����','������',1760,1865.6,1865.6,'���� �����','08-26-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'17920824','08-26-2024','60',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� +����� �������� ','�����','������',678,718.68,718.68,'���� �����','08-26-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'17920824','08-26-2024','61',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� ���� ������ ','�����','������',491,520.46,520.46,'���� �����','08-26-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'17920824','08-26-2024','62',792,'����� ���� ������ �����',30,'�������','��� ����  ','����� �������� ','�����','������',748,792.88,792.88,'���� �����','08-26-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'17930824','09-08-2024','3691',793,'����� ���� ��������',25,'������� ������� ','���� �������  ','����� ','���','������',83,87.98,87.98,'���� �����','09-08-2024',NULL,'���� ������','��',NULL,2024,'���"�','11-2023')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-30-2024','190624',793,'����� ���� ��������',25,'�������� ��������  �������','������� �����','����� �������� ','����','������',66,69.96,69.96,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','14450724','08-27-2024','14450724',795,'����� ���� ��������',24,'���� ��������','����','����� ���� ���� �������� 24','������','������',20821,22070.26,22070.26,'��� ����"�','10-14-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'17950824','08-27-2024','270824',795,'����� ���� ��������',22,'����� �������','������ �����  ','����� �������� ����� �� ���� 24','����','������',518072,549156.32,549156.32,'���� �����','08-27-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-30-2024','240724',793,'����� ���� ��������',25,'�������� ��������  �������','������� �����','����� �������� ','����','������',43.22,45.8132,45.8132,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'17920824','08-27-2024','1002',792,'����� ���� ������ �����',30,'�������',' ��� �����                 ','�����, �����, ����� �����,������','����','������',48200,51092,51092,'���� �����','08-27-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-30-2024','290524',793,'����� ���� ��������',25,'�������� ��������  �������','������� �����','����� �������� ','����','������',50,53,53,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('������','36-24-0004','2024-01','03-24-2024','2024-01',NULL,'����� �������',5,'�����','������ �����  ','����� �����  12/23 �� 3/24','���� ','������',142899,142899,142899,'��� ����"�','04-07-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','03-2024')
 INSERT [Invoices] VALUES('����',NULL,'17910824','08-29-2024','233000054',791,'����� ���� ��',16,'�� �������� ������ ����� ','�������� ��"�  ','������� ����� ����� �21 ����� - ���� ������ ','����','������',9828,10417.68,10417.68,'���� �����','08-29-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('������','36-24-0071','90031360','08-29-2024','90031360',NULL,'����� ���� ��������',25,'������� ������� ',' ���������� �������       ','����� ������� ����� � ���� ','����','������',0,194394,194394,'��� ����"�','11-12-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'17870824','08-29-2024','IN244000625',787,'����� �������',3,'����� ������','������ ����  ','����� ��� ��� 08/24','����','������',34800,36888,36888,'���� �����','08-29-2024',NULL,'���� ������','�� ','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'17940824','08-29-2024','562',794,'���� ������',33,'��� ��� ������','����� �������  ','����� ���� ���� ����� ����� ','���','������',7000,7420,7420,'���� �����','08-29-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930624','06-04-2024','40204',793,'����� ���� ��������',25,'�������� ��������  �������','����� ������','���� ���� ����� ������ ','����','������',3071.25,3255.525,3255.525,'��� ����"�','08-04-2024',NULL,'��',NULL,NULL,2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-0011','1943','09-01-2024','1943',795,'����� ���� ��������',19,'������ �������� ','����� ���������  ','���� ������ ����� �������� ��� �� ���� ','����','������',0,10000,10000,'��� ����"�','09-01-2024',NULL,'���� ������','��','06-13-2024',2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17930624','06-04-2024','40084',793,'����� ���� ��������',25,'�������� ��������  �������','����� ������','���� ����� ����','����','������',1500,1590,1590,'��� ����"�','08-04-2024',NULL,'��',NULL,NULL,2024,'���"�','05-2024')
 INSERT [Invoices] VALUES('����',NULL,'17920824','09-03-2024','1000',792,'����� ���� ������ �����',30,'�������',' ��� �����                 ','����� ���� , ����� ������ ','����','������',26000,27560,27560,'���� �����','09-02-2024',NULL,'���� ������','�� ','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'17920824','07-18-2024','40025',792,'����� ���� ������ �����',30,'�������','����� ������','���� ������ ','�����','������',3000,3180,3180,'���� �����','07-18-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910624','07-01-2024','385',791,'����� ���� ��',17,'���� ���� ','����� ������','����� ������ ����  ������ ���� ���� ','����','������',150,159,159,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����',NULL,'17930824','09-03-2024','46',794,'���� ������',38,'������������','����� ��������  ','����� ������������� ����� ������  2024','���','������',28809,30537.54,30537.54,'���� �����','09-03-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910624','07-01-2024','386',791,'����� ���� ��',17,'���� ���� ','����� ������','����� ������ ����  ������ ���� ���� ','����','������',150,159,159,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����',NULL,'17910824','09-03-2024','3921',791,'����� ���� ��',17,'���� ���� ','������� �����  ','����� ','����','������',1192.5,1264.05,1264.05,'���� �����','09-03-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'7930824','09-03-2024','7930824',793,'����� ���� ��������',25,'������� ','����','��� ������ ������ 24','����','���',87678.78,92939.5068,73617.92,'���� �����','09-03-2024','������� ������� ����','���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'7950824','09-03-2024','7950824',795,'����� ���� ��������',21,'��� ���� �����','����','��� ������ ������ 24','����','���',10361,10982.66,10982.66,'���� �����','10-01-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'7940824','09-03-2024','7940824',794,'���� ������',33,'��� ��� ������','����','��� ������ ������ 24','����','���',76482,81070.92,81070.92,'���� �����','09-03-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'7900824','09-03-2024','7900824',790,'����� �����',1,'����� �����','����','��� ������ ������ 24','����','���',131628.58,139526.2948,18767,'���� �����','09-03-2024','��� ��� ����','���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'7920824','09-03-2024','7920824',792,'����� ���� ������ �����',29,'����� ����','����','��� ������ ������ 24','����','���',753903.45,799137.657,799137.657,'���� �����','09-03-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����','36-24-227','7850724','09-19-2024','7850724',787,'����� �������',6,'����� ����� ������ ����� ������ �������','����','��� ������ ���� ','����','���',23736.6,25160.796,25160.796,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'7850824','09-03-2024','7850824',787,'����� �������',6,'����� ����� ������ ����� ������ �������','����','��� ������ ������ 24','����','���',7710,8172.6,8172.6,'���� �����','10-01-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'7870824','09-03-2024','7870824',787,'����� �������',5,'��� ���� ����� ������ ������ ','����','��� ������ ������ 24','����','���',14589.5,15464.87,15464.87,'���� �����','10-01-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'7910824','09-03-2024','7910824',791,'����� ���� ��',17,'���� ���� ','����','��� ����� ������ 24','����','���',11210,11882.6,11766.5,'���� �����','10-01-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����','36-24-227','4450824','09-03-2024','4450824',795,'����� ���� ��������',24,'���� ��������','����','��� ������ 2024','����','���',9635,10213.1,10213.1,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����','36-24-227','14450824','09-03-2024','14550824',795,'����� ���� ��������',24,'���� ��������','����','����� ������ 24','����','������',183634.69,194652.7714,194652.7714,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'9630824','09-03-2024','9630824',963,'���� ������',37,'����"�','����','��� ����� ������  2024','����','���',241498.86,253573.803,253573.803,'���� �����','09-03-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'9610824','09-03-2024','9610824',961,'���� ������',34,'�����','����','��� ������ ����� 08/24','����','���',38595.01,40524.7605,40524.7605,'���� �����','09-03-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'9660824','09-03-2024','9660824',966,'���� ������',34,'����������','����','��� ������ ��������� ������  24','����','���',34.11,35.8155,35.8155,'���� �����','09-03-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����','36-24-227','19610824','09-03-2024','19610824',961,'���� ������',34,'�����','����','����� ����� 08/24','����','������',154734,162470.7,162470.7,'��� ����"�','10-07-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'17950824','09-04-2024','290824',795,'����� ���� ��������',24,'���� ��������','������ �����  ','����� ����� ���� �������� ����','���� ','���',45000,47700,47700,'���� �����','09-04-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'17930824','09-08-2024','8120570',793,'����� ���� ��������',25,'������� ������� ',' ������ ����               ','������ ','���','������',80,84.8,84.8,'���� �����','09-08-2024',NULL,'���� ������','��',NULL,2024,'���"�','06-2023')
 INSERT [Invoices] VALUES('����',NULL,'17930824','09-08-2024','8132662',793,'����� ���� ��������',25,'������� ������� ',' ������ ����               ','������ ','���','������',25,26.5,26.5,'���� �����','09-08-2024',NULL,'���� ������','��',NULL,2024,'���"�','10-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910624','07-01-2024','387',791,'����� ���� ��',17,'���� ���� ','����� ������','����� ������ ����  ������ ���� ���� ','����','������',150,159,159,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17910624','07-01-2024','388',791,'����� ���� ��',17,'���� ���� ','����� ������','����� ������ ����  ������ ���� ���� ','����','������',150,159,159,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����',NULL,'57900724','09-09-2024','2002',790,'����� �����',1,'����� �����','��� ��������  ','��� ���� 24','����','���',41535,44027.1,0,'���� �����','09-09-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'57900824','09-09-2024','2004',790,'����� �����',1,'����� �����','��� ��������  ','��� ������ 24','����','���',41535,44027.1,0,'���� �����','09-09-2024',NULL,'��',NULL,NULL,2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'17950924','09-10-2024','100924',795,'����� ���� ��������',22,'����� �������','������ �����  ','�������� ����� ������ 24','����','������',25992.97,27552.5482,27552.5482,'���� �����','09-10-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','09-16-2024','1638',787,'����� �������',5,'������ ������ ',' ������ �����              ','����� ������ ������ ���� ','����','������',27000,28620,28620,'���� �����','09-16-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'IN244000007','07-28-2024','IN244000007',793,'����� ���� ��������',25,'�������� ��������  �������','�����','����� ����� ������� ','����','������',20000,21200,21200,'��� ����"�','07-28-2024','������ �����','��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'17920824','07-18-2024','832',792,'����� ���� ������ �����',30,'�������','����� �� �����','����� ������� �������� ��� ����� ������ ������ 7/24','�����','������',800,848,848,'���� �����','07-18-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-160','17870624','06-27-2024','9098',787,'����� �������',3,'����� ������','������','����� ����� ����� ������� ������� ���� ��� ��� ������.','�����','������',17550,18603,18603,'��� ����"�','07-30-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����',NULL,'17910924','09-22-2024','40070',791,'����� ���� ��',12,'������� ���� ���� ��������','������  ','������ ������� ����� ����� ����� ������  24','����','���',23400,24804,24804,'���� �����','09-22-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','09-2024')
 INSERT [Invoices] VALUES('����',NULL,'17870824','08-15-2024','9101',787,'����� �������',3,'����� ������','������','����� ����� ����� ������� ������� ���� ��� ��� ������.','�����','������',23400,24804,24804,'���� �����','08-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','10-01-2024','30005',790,'����� �����',1,'����� �����','���� �������  ','����','����','������',900,954,954,'���� �����','10-01-2024',NULL,'��',NULL,NULL,2024,'���"�','09-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','10-01-2024','30006',790,'����� �����',1,'����� �����','���� �������  ','����','����','������',900,954,954,'���� �����','10-01-2024',NULL,'��',NULL,NULL,2024,'���"�','10-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-30-2024','20624',793,'����� ���� ��������',25,'�������� ��������  �������','������ ������','����� �������� ','����','������',42.1,44.626,44.626,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'17910924','10-01-2024','4026',791,'����� ���� ��',17,'���� ���� ','������� �����  ','����� ','����','������',2107.5,2233.95,2233.95,'���� �����','10-01-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','09-2024')
 INSERT [Invoices] VALUES('����',NULL,'7950924','10-01-2024','7950924',795,'����� ���� ��������',21,'��� ���� �����','����','��� ���� 09/24','����','���',10864.3867924528,11516.25,11516.25,'���� �����','10-01-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','09-2024')
 INSERT [Invoices] VALUES('����',NULL,'17910924','10-01-2024','7910924',791,'����� ���� ��',17,'���� ����','����','��� ����� 09/24','����','���',12100.6603773585,12826.7,12826.7,'���� �����','10-01-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','09-2024')
 INSERT [Invoices] VALUES('����',NULL,'7920924','10-01-2024','7920924',792,'����� ���� ������ �����',29,'����� ����','����','��� ������ 09/24','����','���',779501.886792453,826272,826272,'���� �����','10-01-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','09-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','10-01-2024','7900924',790,'����� �����',1,'����� �����','����','��� ������ 09/24','����','���',128101.41509434,135787.5,135787.5,'���� �����','10-01-2024',NULL,'��',NULL,NULL,2024,'���"�','09-2024')
 INSERT [Invoices] VALUES('����',NULL,'7930924','10-01-2024','7930924',793,'����� ���� ��������',25,'�������','����','��� ������ 09/24','����','���',99295.2830188679,105253,105253,'���� �����','10-01-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','09-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','10-01-2024','7850924',787,'����� �������',6,'����� ����� ������ ����� ������ �������','����','��� ������ 09//24','����','���',53177.0754716981,56367.7,56367.7,'���� �����','10-01-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','09-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','10-01-2024','7940924',794,'���� ������',33,'��� ��� ������','����','��� ������ 09/24','����','���',90566.9811320755,96001,96001,'���� �����','10-01-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','09-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','10-01-2024','7870924',787,'����� �������',5,'��� ���� ','����','��� ������ 09/24','����','���',11991.5094339623,12711,12711,'���� �����','10-01-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','09-2024')
 INSERT [Invoices] VALUES('����',NULL,'19610924','10-07-2024','19610924',961,'���� ������',34,'�����','����','����� ������ 24','����','������',7000,7350,7350,'���� �����','10-07-2024',NULL,'���� ������','��',NULL,2024,'���"�','09-2024')
 INSERT [Invoices] VALUES('����',NULL,'17910924','10-07-2024','1637',791,'����� ���� ��',14,'����� ����� ������',' ������ �����              ','�� ������� ��� ����� ����� ������ ','����','������',2808,2976.48,2976.48,'���� �����','10-07-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','09-2024')
 INSERT [Invoices] VALUES('����',NULL,'17930924','10-08-2024','���� ����� ',793,'����� ���� ��������',25,'������� ������� ',' ��� �����                 ','����� ����������','���','������',2600,2756,2756,'���� �����','10-08-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','09-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','10-08-2024','2005',790,'����� �����',1,'����� �����','��� ��������  ','��� ������ 2024','����','���',41535,44027.1,0,'���� �����','10-08-2024',NULL,'��',NULL,NULL,2024,'���"�','09-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','10-10-2024','500232',790,'����� �����',1,'����� �����','���� ���� ��"�  ','����','����','������',2250,2385,2385,'���� �����','10-10-2024',NULL,'��',NULL,NULL,2024,'���"�','09-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-30-2024','180724',793,'����� ���� ��������',25,'�������� ��������  �������','������ ������','����� �������� ','����','������',57,60.42,60.42,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-30-2024','60624',793,'����� ���� ��������',25,'�������� ��������  �������','������ ������','����� �������� ','����','������',63.4,67.204,67.204,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','10-27-2024','40071',791,'����� ���� ��',14,'����� ������ ','������  ','����� ������ ������� 2024','����','���',23400,24804,24804,'���� �����','10-27-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','10-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17930724','07-30-2024','230524',793,'����� ���� ��������',25,'�������� ��������  �������','������ ������','����� �������� ','����','������',148.7,157.622,157.622,'��� ����"�','10-07-2024',NULL,'��',NULL,NULL,2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'17920824','08-27-2024','20',792,'����� ���� ������ �����',30,'�������','�������','������ ������ �����, ������ ����� ','����','������',48100,50986,50986,'���� �����','08-27-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','08-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','11-03-2024','8179227',793,'����� �����',25,'������� ������� ',' ������ ����               ','���� ','���','������',34,36.04,36.04,'���� �����','11-03-2024',NULL,'���� ������','��',NULL,2024,'���"�','09-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','11-03-2024','47',794,'���� ������',38,'������������','����� ��������  ','����� ������������  ������ 2024','���','������',104573,110847.38,110847.38,'���� �����','11-03-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','10-2024')
 INSERT [Invoices] VALUES('����','36-24-227','17920624','07-04-2024','40086',792,'����� ���� ������ �����',30,'�������','������� �����','���� �� ���� 6/24','�����','������',9000,9540,9540,'��� ����"�','09-15-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','06-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','11-04-2024','7851024',787,'����� �������',6,'����� ����� ������ ����� ������ �������','����','��� ������ 10/24','����','���',15796.56,16744.3536,16744.3536,'���� �����','11-04-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','10-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','11-04-2024','7871024',787,'����� �������',5,'��� ���� ����� ������ ������ ','����','��� ������ 10/24','����','���',15280.27,16197.0862,16197.0862,'���� �����','11-04-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','10-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','11-04-2024','7901024',790,'����� �����',1,'����� �����','����','��� ������ 10/24','����','���',127781.64,135448.5384,18355.31,'���� �����','11-04-2024','��� ��� ����','���� ������','��','12-01-2024',2024,'���"�','10-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','11-04-2024','7911024',791,'����� ���� ��',14,'����� ������ ','����','��� ������ 10/24','����','���',27918.5,29593.61,29593.61,'���� �����','11-04-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','10-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','11-04-2024','7921024',792,'����� ���� ������ �����',29,'����� ����','����','��� ������ 10/24','����','���',891976.44,945495.0264,945495.0264,'���� �����','11-04-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','10-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','11-04-2024','7931024',793,'����� ���� ��������',25,'������� ','����','��� ������ 10/24','����','���',112419.02,119164.1612,107557,'���� �����','11-04-2024','������� ������� +������� ','���� ������','��','12-01-2024',2024,'���"�','10-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','11-04-2024','7941024',794,'���� ������',33,'��� ��� ������','����','��� ������ 10/24','����','���',79586.67,84361.8702,84361.8702,'���� �����','11-04-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','10-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','11-04-2024','7951024',795,'����� ���� ��������',21,'��� ���� �����','����','��� ������ 10/24','����','���',10067.94,10672.0164,10672.0164,'���� �����','11-04-2024','������ ? ','���� ������','��','12-01-2024',2024,'���"�','10-2024')
 INSERT [Invoices] VALUES('������','36-24-0001','10724','07-09-2024','10724',NULL,'����� �������',5,'������','��������','�����  ������� �� ���� 24','����','������',89440,89440,89440,'��� ����"�','07-30-2024',NULL,'���� ������','��','08-30-2024',2024,'���"�','07-2024')
 INSERT [Invoices] VALUES('����',NULL,'���� ����� ','11-13-2024','10079',787,'����� �������',3,'����� ������','�� �������  ','����� ������','����','���',2400,2544,2544,'���� �����','11-13-2024',NULL,'���� ������','��','12-01-2024',2024,'���"�','10-2024')
GO




