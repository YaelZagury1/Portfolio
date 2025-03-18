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
	CONSTRAINT [CK_Study_Year] CHECK ([Study_Year] in ('תשפ"ד' , 'תשפ"ה' , 'תשפ"ו' , 'תשפ"ז' , 'תשפ"ח')
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
	CONSTRAINT [CK_Order_Study_Year] CHECK ([Study_Year] in ('תשפ"ד' , 'תשפ"ה' , 'תשפ"ו' , 'תשפ"ז' , 'תשפ"ח') )
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
	CONSTRAINT [CK_Pay_Channel] CHECK ([Pay_Channel] IN ('לביא' , 'עירייה')
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
	CONSTRAINT [CK_Salaries_Or_Activity] CHECK ([Salaries_Or_Activity] in ('שכר' , 'פעילות')
	),
	CONSTRAINT [CK_Invoice_Status] CHECK ([Status] in ('בקשת תשלום' , 'דואר פנימי לביא' , 'ציון' , 'אורית' , 'נסרק והועבר לשולי' , 'בחתימות' ,
													   'עבר להנה"ח' , 'בוטל' , 'עירייה- בטיפול' , 'נבילה' , 'ממתין להזמנת עבודה' , 'על חשבון הכנסות אחרות')
	),
	CONSTRAINT [CK_For_Reporting] CHECK ([For_Reporting] in ('לא' , 'משרד החינוך' , 'משרד ירושלים' , 'קרן ירושלים' , 'ס.פ.ל' , 'ראסל-ברי')
	),
	CONSTRAINT [CK_Was_Reported] CHECK ([Was_Reported] in ('לא' , 'כן')
	),
	CONSTRAINT [CK_Invoice_Study_Year] CHECK ([Study_Year] in ('תשפ"ד' , 'תשפ"ה' , 'תשפ"ו' , 'תשפ"ז' , 'תשפ"ח')
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
  WHERE I.Study_Year = 'תשפ"ה'),
 B AS
 (SELECT DISTINCT
       I.Project_ID
	  ,SUM (I.To_Report) OVER (PARTITION BY I.Project_ID) AS Reported
  FROM [dbo].[Invoices] I
  WHERE 1=1
        AND I.For_Reporting = 'משרד החינוך'
		AND I.Was_Reported = 'כן'
		AND I.Study_Year = 'תשפ"ה'),
C AS
 (SELECT DISTINCT
       I.Project_ID
	  ,SUM (I.To_Report) OVER (PARTITION BY I.Project_ID) AS Not_Reported
  FROM [dbo].[Invoices] I
  WHERE 1=1
        AND I.For_Reporting = 'משרד החינוך'
		AND I.Was_Reported = 'לא'
		AND I.Study_Year = 'תשפ"ה')
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
INSERT [Targets] ([Target],[Short_Target]) VALUES ('ניהול ובקרה' , 'ניהול ובקרה' )
INSERT [Targets] ([Target],[Short_Target]) VALUES ('הגדלת התכנית הישראלית והכנה לאקדמיה' , 'תכנית ישראלית' )
INSERT [Targets] ([Target],[Short_Target]) VALUES ('חיזוק האוריינות השפתית בעברית ' , 'עברית ושפת אם' )
INSERT [Targets] ([Target],[Short_Target]) VALUES ('חיזוק החינוך המדעי טכנולוגי ' , 'חינוך מדעי טכנולוגי' )
INSERT [Targets] ([Target],[Short_Target]) VALUES ('צמצום נשירה, קידום אקלים חינוכי מיטבי, מניעת אלימות וטיפול בפרט' , 'טיפול בפרט ומניעת נשירה' )
INSERT [Targets] ([Target],[Short_Target]) VALUES ('חיזוק החינוך הבלתי פורמלי ככלי להעצמה' , 'בלתי פורמלי' )
GO

 /****** INSERT VALUES TO :  Table [Lavy_Codes]    */

INSERT [Lavy_Codes] ([ID_Lavy],[Lavy_Project_Name],[Code_Discription],[Dpartment],[Target_In_The_Program]) VALUES ('790' , 'ניהול ובקרה מזרח' , 'צוות החומש, אסטרטגיה' , 'מנח"י' , 'ניהול ובקרה')
INSERT [Lavy_Codes] ([ID_Lavy],[Lavy_Project_Name],[Code_Discription],[Dpartment],[Target_In_The_Program]) VALUES ('791' , 'פדגוגיה מזרח' , 'הכשרה, ליווי ושיפור ההוראה והלמידה בשפה העברית. חיזוק השפה הערבית' , 'מנח"י' , 'עברית ושפת אם')
INSERT [Lavy_Codes] ([ID_Lavy],[Lavy_Project_Name],[Code_Discription],[Dpartment],[Target_In_The_Program]) VALUES ('792' , 'טיפול בפרט מזרח' , 'עובדים סוציאלים,עובדי מל"א, אולפני עברית לפסיכולוגים כולל ליווי והכשרות. תיאטרון, תכניות מניעת נשירה' , 'מנח"י ' , 'טיפול בפרט ומניעת נשירה')
INSERT [Lavy_Codes] ([ID_Lavy],[Lavy_Project_Name],[Code_Discription],[Dpartment],[Target_In_The_Program]) VALUES ('793' , 'מצויינות ואקדמיה' , 'אלבשאיר סטודנטים' , 'מנח"י' , 'חינוך מדעי טכנולוגי')
INSERT [Lavy_Codes] ([ID_Lavy],[Lavy_Project_Name],[Code_Discription],[Dpartment],[Target_In_The_Program]) VALUES ('794' , 'חינוך מוזיקלי מזרח' , 'בתי ספר מנגנים, קונסרבטוריון' , 'מנח"י' , 'בלתי פורמלי')
INSERT [Lavy_Codes] ([ID_Lavy],[Lavy_Project_Name],[Code_Discription],[Dpartment],[Target_In_The_Program]) VALUES ('795' , 'חינוך טכנולוגי מזרח' , 'קורסים טכנולוגים, מגמות טכנולוגיות, מעבדות, כנסים וטעימות טכנולוגיות. אלבשאיר תלמידים, מרכז מצטיינים, מרכז מחוננים' , 'מנח"י' , 'חינוך מדעי טכנולוגי')
INSERT [Lavy_Codes] ([ID_Lavy],[Lavy_Project_Name],[Code_Discription],[Dpartment],[Target_In_The_Program]) VALUES ('787' , 'תכנית ישראלית' , 'פיתוח מקצועי וליווי לצוותי הוראה, העלאת זכאות לבגרויות, שיפור הישגים, סיוע במעבר לתכנית ישראלית' , 'מנח"י' , 'תכנית ישראלית')
INSERT [Lavy_Codes] ([ID_Lavy],[Lavy_Project_Name],[Code_Discription],[Dpartment],[Target_In_The_Program]) VALUES ('961' , 'העצמה' , 'תכניות העצמה לבני נוער' , 'חברה' , 'בלתי פורמלי')
INSERT [Lavy_Codes] ([ID_Lavy],[Lavy_Project_Name],[Code_Discription],[Dpartment],[Target_In_The_Program]) VALUES ('963' , 'מדצים' , 'תנועת נוער צעירים+בוגרים' , 'חברה' , 'בלתי פורמלי')
INSERT [Lavy_Codes] ([ID_Lavy],[Lavy_Project_Name],[Code_Discription],[Dpartment],[Target_In_The_Program]) VALUES ('966' , 'העצמה יוניברסיטי' , 'תכניות העצמה לבני נוער' , 'חברה' , 'בלתי פורמלי')
GO

 /****** INSERT VALUES TO :  Table [Projects]    */

INSERT [Projects] VALUES('ניהול ובקרה' , 'תשפ"ה' , 'ניהול ובקרה' , '2292000' , '0')
INSERT [Projects] VALUES('תכנית ישראלית' , 'תשפ"ה' , 'תרביה 2.0 - פיתוח הון אנושי' , '292500' , '292500')
INSERT [Projects] VALUES('תכנית ישראלית' , 'תשפ"ה' , 'ליווי פדגוגי' , '2349999.99' , '2349999.99')
INSERT [Projects] VALUES('תכנית ישראלית' , 'תשפ"ה' , 'העלאת הזכאות לבגרות איכותית ' , '500000' , '500000')
INSERT [Projects] VALUES('תכנית ישראלית' , 'תשפ"ה' , 'תוכניות לשיפור הישגים ומיומנויות' , '1500000' , '1500000')
INSERT [Projects] VALUES('תכנית ישראלית' , 'תשפ"ה' , 'מעטפת למעבר לתוכנית הישראלית' , '400000' , '400000')
INSERT [Projects] VALUES('תכנית ישראלית' , 'תשפ"ה' , 'ספרי לימוד' , '7000000' , '7000000')
INSERT [Projects] VALUES('תכנית ישראלית' , 'תשפ"ה' , 'שכירות מבנים' , '12000000' , '12000000')
INSERT [Projects] VALUES('תכנית ישראלית' , 'תשפ"ה' , 'אבזור ושיפור פיזי' , '12000000' , '12000000')
INSERT [Projects] VALUES('עברית ושפת אם' , 'תשפ"ה' , 'הוראת עברית במוסדות האקדמיים' , '487600' , '487600')
INSERT [Projects] VALUES('עברית ושפת אם' , 'תשפ"ה' , 'חותם' , '750000' , '750000')
INSERT [Projects] VALUES('עברית ושפת אם' , 'תשפ"ה' , 'אולפנים בתוך שעות הלימודים' , '2000000' , '2000000')
INSERT [Projects] VALUES('עברית ושפת אם' , 'תשפ"ה' , 'הכנה ל- ITEST (שאלון 014386)' , '208000' , '208000')
INSERT [Projects] VALUES('עברית ושפת אם' , 'תשפ"ה' , 'תכנית מדברים' , '1900000' , '1900000')
INSERT [Projects] VALUES('עברית ושפת אם' , 'תשפ"ה' , 'גוף מלווה למחקר על העברית' , '200000' , '200000')
INSERT [Projects] VALUES('עברית ושפת אם' , 'תשפ"ה' , 'עזרי הוראה וטכנולוגיה ' , '200000' , '200000')
INSERT [Projects] VALUES('עברית ושפת אם' , 'תשפ"ה' , 'מרכז שפות ' , '700000' , '700000')
INSERT [Projects] VALUES('עברית ושפת אם' , 'תשפ"ה' , 'העלאת המיומנות השפתית בערבית' , '1260000' , '1260000')
INSERT [Projects] VALUES('חינוך מדעי טכנולוגי' , 'תשפ"ה' , ' מעבדות בלמונטה ' , '306600' , '306600')
INSERT [Projects] VALUES('חינוך מדעי טכנולוגי' , 'תשפ"ה' , ' מעבדות ניידות ' , '150000' , '150000')
INSERT [Projects] VALUES('חינוך מדעי טכנולוגי' , 'תשפ"ה' , ' מגמות מדעיות טכנולוגיות גבוהות  ' , '300000' , '300000')
INSERT [Projects] VALUES('חינוך מדעי טכנולוגי' , 'תשפ"ה' , 'חשיבה חישובית (חוואריזמי)' , '1500000' , '1500000')
INSERT [Projects] VALUES('חינוך מדעי טכנולוגי' , 'תשפ"ה' , 'תחרות חקר מדעים' , '20000' , '20000')
INSERT [Projects] VALUES('חינוך מדעי טכנולוגי' , 'תשפ"ה' , 'מצטיינים' , '1000000' , '1000000')
INSERT [Projects] VALUES('חינוך מדעי טכנולוגי' , 'תשפ"ה' , 'אלבשאיר' , '2000000' , '2000000')
INSERT [Projects] VALUES('חינוך מדעי טכנולוגי' , 'תשפ"ה' , 'קורסים טכנולוגיים' , '2500000' , '2500000')
INSERT [Projects] VALUES('טיפול בפרט ומניעת נשירה' , 'תשפ"ה' , 'שפ"ח - שעות טיפול' , '480000' , '480000')
INSERT [Projects] VALUES('טיפול בפרט ומניעת נשירה' , 'תשפ"ה' , 'שפ"ח - פסיכולוגים חדשים' , '630000' , '630000')
INSERT [Projects] VALUES('טיפול בפרט ומניעת נשירה' , 'תשפ"ה' , 'מרכזי מרפ"א (עו"ס בי"ס)' , '12000000' , '8000000')
INSERT [Projects] VALUES('טיפול בפרט ומניעת נשירה' , 'תשפ"ה' , 'תכניות מניעת נשירה' , '1126400' , '1126400')
INSERT [Projects] VALUES('בלתי פורמלי' , 'תשפ"ה' , 'קרב בגני ילדים ' , '999999.999' , '999999.999')
INSERT [Projects] VALUES('בלתי פורמלי' , 'תשפ"ה' , 'חוגים ביסודי - ג-ו קרב לחנ"מ' , '700000' , '700000')
INSERT [Projects] VALUES('בלתי פורמלי' , 'תשפ"ה' , 'בתי ספר מנגנים ' , '1000000' , '1000000')
INSERT [Projects] VALUES('בלתי פורמלי' , 'תשפ"ה' , 'העצמה: כיתות ז-יב' , '4000000' , '4000000')
INSERT [Projects] VALUES('בלתי פורמלי' , 'תשפ"ה' , 'צופים (ציוד)' , '40000' , '40000')
INSERT [Projects] VALUES('בלתי פורמלי' , 'תשפ"ה' , 'בי"ס השלם - חוגי העצמה' , '1500000' , '1500000')
INSERT [Projects] VALUES('בלתי פורמלי' , 'תשפ"ה' , 'ארגון נוער' , '4800000' , '4800000')
INSERT [Projects] VALUES('בלתי פורמלי' , 'תשפ"ה' , ' קונסרבטוריון' , '1500000' , '1000000')
GO

 /****** INSERT VALUES TO :  Table [Suppliers]    */

INSERT [Suppliers] VALUES(101 , 'ספק כללי בע"מ')
INSERT [Suppliers] VALUES(102 , 'טכנולוגיות מדומות')
INSERT [Suppliers] VALUES(103 , 'פתרונות לוגיסטיים אשליה')
INSERT [Suppliers] VALUES(104 , 'אופטימוס שילוח')
INSERT [Suppliers] VALUES(105 , 'סחר וירטואלי בינלאומי')
INSERT [Suppliers] VALUES(106 , 'מיכון דמיוני')
INSERT [Suppliers] VALUES(107 , 'שילוח מהיר חלומי')
INSERT [Suppliers] VALUES(108 , 'פרויקטים נסיוניים בע"מ')
INSERT [Suppliers] VALUES(109 , 'מערכות הזיה בע"מ')
INSERT [Suppliers] VALUES(110 , 'ציוד חקלאי פיקטיבי')
INSERT [Suppliers] VALUES(111 , 'עמותת לביא')
INSERT [Suppliers] VALUES(112 , 'מסחר עתידי')
INSERT [Suppliers] VALUES(113 , 'לוגיסטיקת כזב בע"מ')
INSERT [Suppliers] VALUES(114 , 'מוצרים חלופיים בע"מ')
INSERT [Suppliers] VALUES(115 , 'אנרגיה דמיונית')
INSERT [Suppliers] VALUES(116 , 'נוי ומדיה בלתי אפשריים')
INSERT [Suppliers] VALUES(117 , 'ציוד רפואי חלומי')
INSERT [Suppliers] VALUES(118 , 'ריהוט משרדי ניסיוני')
INSERT [Suppliers] VALUES(119 , 'סוכנויות מזרח תיכון בע"מ')
GO

 /****** INSERT VALUES TO :  Table [Work_Orders]    */

INSERT [Work_Orders] VALUES('09/01/2023','תשפ"ד',NULL,NULL,'36-23-366','חומש תשפ"ד',111,81679555,NULL,3000000,'סגור',NULL)
INSERT [Work_Orders] VALUES('10/25/2023','תשפ"ד',NULL,NULL,'36-23-325','חומש תשפ"ד',111,81679555,NULL,3000000,'סגור',NULL)
INSERT [Work_Orders] VALUES('12/18/2023','תשפ"ד','36-23-0003',294000,'36-23-403','תכנית העצמה',101,81679555,NULL,294000,'סגור',NULL)
INSERT [Work_Orders] VALUES('12/19/2023','תשפ"ד','36-23-0004',210800,'36-23-405','תכנית קריאה',101,81679555,NULL,210800,'פעיל',NULL)
INSERT [Work_Orders] VALUES('12/24/2023','תשפ"ד',NULL,9000000,'36-23-408','חומש מזרח ירושלים',111,81679555,NULL,9000000,'סגור',NULL)
INSERT [Work_Orders] VALUES('01/01/2024','תשפ"ד','36-24-0001',89400,'36-24-0001','תכנית מצויינים',119,81679555,NULL,89400,'פעיל',NULL)
INSERT [Work_Orders] VALUES('01/16/2024','תשפ"ד','36-24-0003',326400,'36-24-0004','תכנית מניעת נשירה',115,81679555,NULL,326400,'פעיל ',NULL)
INSERT [Work_Orders] VALUES('01/16/2024','תשפ"ד','36-24-0004',316800,'36-24-0005','לימוד אנגלית',117,81679555,NULL,316800,'פעיל',NULL)
INSERT [Work_Orders] VALUES('01/30/2024','תשפ"ד','36-24-0011',420000,'36-24-0011','מעבדות',107,81679555,NULL,420000,'פעיל',NULL)
INSERT [Work_Orders] VALUES('03/07/2024','תשפ"ד','36-24-0005',33600,'36-24-0060','שפות',107,81679555,NULL,33600,'פעיל',NULL)
INSERT [Work_Orders] VALUES('03/13/2024','תשפ"ד','36-24-0006',497685,'36-24-0071','תכנית אקדמיה',107,81679555,NULL,497685,'פעיל ',NULL)
INSERT [Work_Orders] VALUES('04/08/2024','תשפ"ד','97-20-0008',13263,'36-24-100','הסעות',116,81679555,NULL,13263,'פעיל',NULL)
INSERT [Work_Orders] VALUES('04/08/2024','תשפ"ד','97-20-0008',163943.5,'36-24-101','תכנית אקדמיה',118,81679555,NULL,163943.5,'פעיל',NULL)
INSERT [Work_Orders] VALUES('04/08/2024','תשפ"ד',NULL,4000000,'36-24-102','חומש מזרח ירושלים',111,81679555,NULL,4000000,'סגור',NULL)
INSERT [Work_Orders] VALUES('05/01/2024','תשפ"ד','97-20-0008',16866,'36-24-116','הסעות',114,81679555,NULL,14415,'סגור',NULL)
INSERT [Work_Orders] VALUES('06/10/2024','תשפ"ד',NULL,3900000,'36-24-160','חומש מזרח ירושלים',111,81679555,NULL,3900000,'פעיל',NULL)
INSERT [Work_Orders] VALUES('07/07/2024','תשפ"ד','97-20-0008',39240,'36-24-183','תכנית אקדמיה',109,81679555,NULL,39240,'סגור',NULL)
INSERT [Work_Orders] VALUES('08/14/2024','תשפ"ד',NULL,NULL,'36-24-227','חומש תשפ"ד',111,81679555,NULL,7500000,'פעיל',NULL)
INSERT [Work_Orders] VALUES('11/10/2024','תשפ"ה',NULL,NULL,'36-24-277','חומש תשפ"ה',111,81679555,NULL,11000000,'פעיל',NULL)
INSERT [Work_Orders] VALUES('12/24/2023','תשפ"ד',NULL,NULL,'36-24-408','חומש תשפ"ד',111,81679555,NULL,9000000,'סגור',NULL)

GO

 /****** INSERT VALUES TO :  Table [Invoices]    */
 INSERT [Invoices] VALUES('לביא','36-23-325','17900923','09-11-2023','500180',790,'ניהול ובקרה',1,'ניהול ובקרה','זרעי השמש בע"מ','חניה','רבקה','פעילות',2250,2385,0,'עבר להנה"ח','12-31-2023',NULL,'לא',NULL,NULL,2023,'תשפ"ד','09-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','17900923','09-13-2023','78',790,'ניהול ובקרה',1,'ניהול ובקרה','פיקס פתרונות  ','חניה','לביא','שכר',900,954,0,'עבר להנה"ח','12-31-2023',NULL,'לא',NULL,NULL,2023,'תשפ"ד','09-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','17930923','09-15-2023','3082023',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר סטודנטים תואר ראשון','איילון טכנולוגיות  ','הנחיה','יוסי','שכר',4000,4240,0,'עבר להנה"ח','12-10-2023',NULL,'לא',NULL,NULL,2023,'תשפ"ד','09-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','17900923','09-21-2023','1034',790,'ניהול ובקרה',1,'אסטרטגיה','נחשוני פתרונות  ','שכר יולי 2023','לביא','שכר',5850,6201,0,'עבר להנה"ח','12-31-2023',NULL,'לא',NULL,NULL,2023,'תשפ"ד','09-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','17900923','09-21-2023','1035',790,'ניהול ובקרה',1,'אסטרטגיה','נחשוני פתרונות  ','שכר אוגוסט 2023','לביא','שכר',5850,6201,0,'עבר להנה"ח','12-31-2023',NULL,'לא',NULL,NULL,2023,'תשפ"ד','09-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','17900923','10-01-2023','500186',790,'ניהול ובקרה',1,'ניהול ובקרה','זרעי השמש בע"מ  ','חניה','רבקה','פעילות',2250,2385,0,'עבר להנה"ח','12-31-2023',NULL,'לא',NULL,NULL,2023,'תשפ"ד','10-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','19620923','10-18-2023','19620923',963,'בלתי פורמלי',37,'ארגון נוער','לביא','ספקים ארגון נוער אוגוסט 2023','בתיה','פעילות',28000,29400,0,'עבר להנה"ח','12-10-2023','חורג מהתקציב השנתי','לא',NULL,NULL,2023,'תשפ"ד','09-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','19630923','10-18-2023','19630923',963,'בלתי פורמלי',37,'מדצי"ם','לביא','ספקים מדצים אוגוסט 2023','בתיה','פעילות',28000,29400,0,'עבר להנה"ח','12-10-2023','חורג מהתקציב השנתי','לא',NULL,NULL,2023,'תשפ"ד','09-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','4450923','10-22-2023','4450923',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','שכר מרכז מצטיינים ספטמבר 2023','מנון','שכר',13212.9905660377,14005.77,14005.77,'עבר להנה"ח','12-10-2023',NULL,'משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','09-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','14450923','10-22-2023','14450923',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','ספקים מרכז מצטיינים דספטמר 2023','מנון','פעילות',15500,16430,16430,'עבר להנה"ח','12-10-2023',NULL,'משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','09-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','7900923','10-01-2023','7900923',790,'ניהול ובקרה',1,'ניהול ובקרה','לביא','שכר עובדים ספטמבר 2023','לביא','שכר',141141.622641509,149610.12,18068.62,'עבר להנה"ח','12-31-2023','שכר עבד בלבד','משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','09-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','7920923','10-01-2023','7920923',792,'טיפול בפרט ומניעת נשירה',29,'טיפול בפרט','לביא','שכר עובדים ספטמבר 2023','לביא','שכר',697176.990566038,739007.61,739007.61,'עבר להנה"ח','12-31-2023',NULL,'משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','09-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','7930923','10-01-2023','7930923',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר ','לביא','שכר עובדים ספטמבר 2023','לביא','שכר',102954.735849057,109132.02,70070,'עבר להנה"ח','12-31-2023','אלבשאיר תלמידים בלבד','משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','09-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','7940923','10-01-2023','7940923',794,'בלתי פורמלי',33,'בתי ספר מנגנים','לביא','שכר עובדים ספטמבר 2023','לביא','שכר',77121.8018867925,81749.11,81749.11,'עבר להנה"ח','12-31-2023',NULL,'משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','09-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','7950923','10-01-2023','7950923',795,'חינוך מדעי טכנולוגי',21,'חדר כושר אלקמה','לביא','שכר עובדים ספטמבר 2023','לביא','שכר',18297.6886792453,19395.55,0,'עבר להנה"ח','12-31-2023','חדר כושר בי"ס אלקמה','לא',NULL,NULL,2023,'תשפ"ד','09-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','7871023','11-02-2023','7871023',787,'תכנית ישראלית',5,'קלף מנצח','לביא','שכר עובדים אוקטובר 2023','לביא','שכר',9313.88679245283,9872.72,9872.72,'עבר להנה"ח','12-31-2023','קלף מנצח','משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','10-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','7901023','11-02-2023','7901023',790,'ניהול ובקרה',1,'ניהול ובקרה','לביא','שכר עובדים אוקטובר 2023','לביא','שכר',109679.264150943,116260.02,17557.62,'עבר להנה"ח','12-31-2023','שכר עבד בלבד','משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','10-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','7921023','11-02-2023','7921023',792,'טיפול בפרט ומניעת נשירה',29,'טיפול בפרט','לביא','שכר עובדים אוקטובר 2023','לביא','שכר',893335.066037736,946935.17,946935.17,'עבר להנה"ח','12-31-2023','עוסים, מלא ותיאטרון','משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','10-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','7931023','11-02-2023','7931023',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר ','לביא','שכר עובדים אוקטובר 2023','לביא','שכר',100942.764150943,106999.33,65384,'עבר להנה"ח','12-31-2023','אלבשאיר תלמידים בלבד','משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','10-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','7941023','11-02-2023','7941023',794,'בלתי פורמלי',33,'בתי ספר מנגנים','לביא','שכר עובדים אוקטובר 2023','לביא','שכר',62545.4245283019,66298.15,66298.15,'עבר להנה"ח','12-31-2023','מורים בי"ס מנגן','משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','10-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','7951023','11-02-2023','7951023',795,'חינוך מדעי טכנולוגי',21,'חדר כושר אלקמה','לביא','שכר עובדים אוקטובר 2023','לביא','שכר',21000.6226415094,22260.66,0,'עבר להנה"ח','01-22-2024','חדר כושר אלקמה','לא',NULL,NULL,2023,'תשפ"ד','10-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','17941023','10-30-2023','35',794,'בלתי פורמלי',38,'קונסרבטוריון','המרכז המוזיקלי  ','שוטף קונסרבטוריון ספטמבר 2023','ברק','פעילות',99853,105844.18,105844.18,'עבר להנה"ח','12-10-2023','חלק מהחשבונית שייך ליב"ס מנגן','משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','10-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','17901023','10-30-2023','80',790,'ניהול ובקרה',1,'ניהול ובקרה','פיקס פתרונות  ','חניה','לביא','שכר',900,954,0,'עבר להנה"ח','12-10-2023',NULL,'לא',NULL,NULL,2023,'תשפ"ד','10-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','17901023','10-30-2023','84',790,'ניהול ובקרה',1,'ניהול ובקרה','פיקס פתרונות  ','חניה','לביא','שכר',900,954,0,'עבר להנה"ח','12-10-2023',NULL,'לא',NULL,NULL,2023,'תשפ"ד','10-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','17901023','10-30-2023','500192',790,'ניהול ובקרה',1,'ניהול ובקרה','זרעי השמש בע"מ  ','חניה','רבקה','פעילות',2250,2385,0,'עבר להנה"ח','12-10-2023',NULL,'לא',NULL,NULL,2023,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','17931023','10-30-2023','40280',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר סטודנטים תואר ראשון','מעלה מערכות  ','הנחיה','ולאא','שכר',25740,27284.4,0,'עבר להנה"ח','12-14-2023',NULL,'לא',NULL,NULL,2023,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','17931023','11-05-2023','30923',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר סטודנטים תואר ראשון','איילון טכנולוגיות  ','הנחיה','ולאא','שכר',4000,4240,0,'עבר להנה"ח','12-14-2023',NULL,'לא',NULL,NULL,2023,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','14451023','11-05-2023','14451023',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','ספקים מרכז מצטיינים אוקטובר 23','מנון','פעילות',18756.4,19881.784,19881.784,'עבר להנה"ח','12-10-2023',NULL,'משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','10-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','17901123','11-19-2023','1038',790,'ניהול ובקרה',1,'אסטרטגיה','נחשוני פתרונות  ','שכר ספטמבר 2023','לביא','שכר',5850,6201,0,'עבר להנה"ח','01-21-2024',NULL,'לא',NULL,NULL,2023,'תשפ"ד','09-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','17901123','11-19-2023','1039',790,'ניהול ובקרה',1,'אסטרטגיה','נחשוני פתרונות  ','שכר אוקטובר 2023','לביא','שכר',5850,6201,0,'עבר להנה"ח','01-21-2024',NULL,'לא',NULL,NULL,2023,'תשפ"ד','10-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','17901123','12-01-2023','500198',790,'ניהול ובקרה',1,'ניהול ובקרה','זרעי השמש בע"מ  ','חניה','רבקה','פעילות',2250,2385,0,'עבר להנה"ח','01-21-2024',NULL,'לא',NULL,NULL,2023,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','17921123','12-01-2023','10062',792,'טיפול בפרט ומניעת נשירה',29,'טיפול בפרט','לב האקדמיה  ','ליווי חינוכי','נעמה','פעילות',2400,2544,2544,'עבר להנה"ח','12-31-2023',NULL,'משרד החינוך','כן','03-30-2024',2023,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','17941123','11-28-2023','36',794,'בלתי פורמלי',38,'קונסרבטוריון','המרכז המוזיקלי  ','ניהול הקונסרבטוריון לחודש אוקטובר 2023 ','ברק','פעילות',114657,121536.42,121536.42,'עבר להנה"ח','02-04-2024',NULL,'משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','17871123','12-03-2023','500268',787,'תכנית ישראלית',6,'תכנית ישראלית','גן הממלכה  ','בי"ס איליה- פעילות בגן החיות תחילת תשפ"ד','לביא','פעילות',1520,1611.2,1611.2,'עבר להנה"ח','01-23-2024',NULL,'משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','9630923','12-10-2023','9630923',963,'בלתי פורמלי',37,'מדצי"ם','לביא','שכר מדצי"ם ספטמבר 2023','בתיה','שכר',218777,229716,229716,'עבר להנה"ח','12-31-2023',NULL,'משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','09-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','9620923','12-10-2023','9620923',963,'בלתי פורמלי',37,'ארגון נוער','לביא','שכר ארגון נוער ספטמבר 2023','בתיה','שכר',7701,8086.05,8086.05,'עבר להנה"ח','12-31-2023',NULL,'משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','09-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','9610923','12-10-2023','9610923',961,'בלתי פורמלי',34,'העצמה','לביא','שכר העצמה ספטמבר 2023','בתיה','שכר',4169,4377,4377,'עבר להנה"ח','12-31-2023',NULL,'משרד החינוך','כן','03-30-2024',2023,'תשפ"ד','09-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','4451023','12-10-2023','4451023',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','שכר עובדים 10/23','מנון','שכר',63364,67165.84,67166,'עבר להנה"ח','12-24-2023',NULL,'משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','10-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','4451123','12-10-2023','4451123',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','שכר עובדים 11/23','מנון','שכר',54299,57556.94,57557,'עבר להנה"ח','12-24-2023',NULL,'משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-23-325','14451123','12-10-2023','14451123',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','ספקים מרכז מצטיינים נונבמבר 2023','מנון','פעילות',16337,17317.22,17317,'עבר להנה"ח','12-24-2023',NULL,'משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','17941223','12-06-2023','37',794,'בלתי פורמלי',38,'קונסרבטוריון','המרכז המוזיקלי  ','ניהול הקונסרבטוריון לחדוש נובמבר 2023 ','ברק','פעילות',111699,118400.94,118400.94,'עבר להנה"ח','02-04-2024',NULL,'משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','7951123','12-03-2023','7951123',795,'חינוך מדעי טכנולוגי',21,'חדר כושר אלקמה','לביא','שכר עובדים נובמבר 2023','לביא','שכר',22859,24231,0,'עבר להנה"ח','01-21-2024',NULL,'לא',NULL,NULL,2023,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','7871123','12-03-2023','7871123',787,'תכנית ישראלית',5,'קלף מנצח','לביא','שכר עובדים נובמבר 2023','לביא','שכר',4889,5182,5182,'עבר להנה"ח','01-21-2024','קלף מנצח','משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','7941123','12-03-2023','7941123',794,'בלתי פורמלי',33,'בתי ספר מנגנים','לביא','שכר עובדים נובמבר 2023','לביא','שכר',68285,72382,72382.1,'עבר להנה"ח','01-21-2024',NULL,'משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','7901123','12-03-2023','7901123',790,'ניהול ובקרה',1,'ניהול ובקרה','לביא',' שכר עובדים חודש נובמבר 2023','לביא','שכר',125464,132992,17573.28,'עבר להנה"ח','01-21-2024','שכר עבד בלבד','משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','7931123','12-03-2023','7931123',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר ','לביא','שכר עובדים נובמנבר 2023','לביא','שכר',93533,99145,64956,'עבר להנה"ח','01-21-2024','אלבשאיר תלמידים בלבד','משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','7921123','12-03-2023','7921123',792,'טיפול בפרט ומניעת נשירה',29,'טיפול בפרט','לביא','שכר עובדים נונבמבר 2023','לביא','שכר',808929,857465,857465,'עבר להנה"ח','02-04-2024',NULL,'משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','17921223','12-11-2023','2788',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','חלום עתידי בע"מ  ','סנדוויציים לתיאטרון','אריג','פעילות',1170,1240.2,1240,'עבר להנה"ח','02-04-2024','בתוך תוכניות מניעת נשירה','משרד החינוך','כן','03-30-2024',2023,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','17921223','12-11-2023','2790',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','חלום עתידי בע"מ  ','סנדוויציים לתיאטרון','אריג','פעילות',1105,1171.3,1171.3,'עבר להנה"ח','02-04-2024','בתוך תוכניות מניעת נשירה','משרד החינוך','כן','03-30-2024',2023,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','27941223','12-17-2023','02/000015',794,'בלתי פורמלי',33,'בתי ספר מנגנים','לביא','ציוד מוזיקאלי ','לביא','פעילות',125899,133452.94,133452.94,'עבר להנה"ח','02-26-2024',NULL,'משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','27871223','12-17-2023','PI23000027',787,'תכנית ישראלית',11,'חותם מנהלים','חותם זהב  ','חותם מניגות ירושלמית תשלום 1/2','לביא','פעילות',150000,159000,159000,'עבר להנה"ח','02-13-2024',NULL,'משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','27871223','12-17-2023','PI23000028',787,'תכנית ישראלית',11,'חותם מורים','חותם זהב  ','חותם מורים תשלום 1/2','לביא','פעילות',150000,159000,159000,'עבר להנה"ח','02-13-2024',NULL,'משרד החינוך','כן','12-20-2023',2023,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','17921223','12-18-2023','10063',792,'טיפול בפרט ומניעת נשירה',29,'טיפול בפרט','לב האקדמיה  ','ליווי חינוכי','נעמה','פעילות',900,954,954,'עבר להנה"ח','02-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2023,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','17871123','12-19-2023','5000268',787,'תכנית ישראלית',6,'תכנית ישראלית','גן הממלכה  ','פעילות בגן חיות -ב"יס אליה ','לביא','פעילות',1520,1611.2,1611.2,'עבר להנה"ח','01-21-2024',NULL,'לא',NULL,NULL,2023,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','17871223','12-18-2023','10065',787,'תכנית ישראלית',3,'ליווי פדגוגי','לב האקדמיה  ','ליווי','נעמה','פעילות',9600,10176,10176,'עבר להנה"ח','02-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2023,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','9631023','12-24-2023','9631023',963,'בלתי פורמלי',37,'מדצי"ם','לביא','שכר מדצי"ם אוקטובר 2023','בתיה','שכר',143425,150596,150596,'עבר להנה"ח','01-21-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','10-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','9661023','12-24-2023','9661023',966,'בלתי פורמלי',34,'יוניברסיטי','לביא','שכר יוניברסיטי ספטמבר 2023','בתיה','שכר',-0.41,-0.43,0,'עבר להנה"ח','01-21-2024',NULL,'לא',NULL,NULL,2023,'תשפ"ד','10-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','9631123','12-26-2023','9631123',963,'בלתי פורמלי',37,'מדצי"ם','לביא','שכר מדצי"ם נובמבר 2023','בתיה','שכר',201339,211406,211406,'עבר להנה"ח','01-21-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','9621123','12-26-2023','9621123',963,'בלתי פורמלי',37,'ארגון נוער','לביא','שכר ארגון נוער נובמבר 2023','בתיה','שכר',3670,3853.5,3853.5,'עבר להנה"ח','01-21-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','9661123','12-26-2023','9661123',966,'בלתי פורמלי',34,'יוניברסיטי','לביא','שכר יוניברסיטי נובמבר 2023','בתיה','שכר',4431,4653,4653,'עבר להנה"ח','01-21-2024','לדווח בהעצמה','משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','9611123','12-26-2023','9611123',961,'בלתי פורמלי',34,'העצמה','לביא','שכר העצמה נובמבר 2023','בתיה','שכר',20354,21371,21371,'עבר להנה"ח','01-21-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא',NULL,'על חשבון הכנסות אחרות ','12-31-2023','5246',790,'ניהול ובקרה',1,'ניהול ובקרה','צמרת מחשוב  ','מחשב עבודה','נעמי','פעילות',4000,4240,4240,'על חשבון הכנסות אחרות','01-01-2024',NULL,'לא',NULL,NULL,2023,'תשפ"ד','10-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','17951223','12-27-2023','950930/2',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','מנעולנות קידום נוער 12/2023','עבד','פעילות',12000,12720,12720,'עבר להנה"ח','02-26-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','17951223','12-27-2023','729871/1',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','חשמל ביתי עיסוויה תיכון בנים 12/2023','עבד','פעילות',8000,8480,8480,'עבר להנה"ח','02-26-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','17951223','12-27-2023','641407/1',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','חשמל ביתי תיכון מותנבי מחנה שופעאט 12/2023','עבד','פעילות',8000,8480,8480,'עבר להנה"ח','02-26-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','17951223','12-27-2023','950930/1',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','מנעולנות קידום נוער 11/2023','עבד','פעילות',4000,4240,4240,'עבר להנה"ח','02-26-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','17951223','01-05-2024','10018',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','הכוכב המזרחי  ','קורסים טכנולוגים דצמבר 2023','עבד','פעילות',230833,244682.98,244682.98,'עבר להנה"ח','02-26-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','17951223','01-05-2024','10017',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','הכוכב המזרחי  ','קורסים טכנולוגים נובמבר 2023','עבד','פעילות',26983,28601.98,28601.98,'עבר להנה"ח','02-26-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','7941223','01-09-2024','7941223',794,'בלתי פורמלי',33,'בתי ספר מנגנים','לביא','שכר עובדים דצמבר 2023','לביא ','שכר',69031,73172.86,73172.86,'עבר להנה"ח','02-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2023,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','7951223','01-09-2024','7951223',795,'חינוך מדעי טכנולוגי',21,'חדר כושר אלקמה','לביא','שכר עובדים דצמבר 2023','לביא','שכר',20212,21424.72,0,'עבר להנה"ח','02-04-2024','לבדוק כמה דווח בדצמבר-דווח 22,261','לא',NULL,NULL,2023,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','7901223','01-09-2024','7901223',790,'ניהול ובקרה',1,'ניהול ובקרה','לביא','שכר עובדים דצמבר 2023 ','לביא','שכר',135681,143821.86,17573.28,'עבר להנה"ח','02-04-2024',NULL,'משרד החינוך','כן','12-20-2023',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','7871223','01-09-2024','7871223',787,'תכנית ישראלית',5,'קלף מנצח','לביא','שכר עובדים דצמבר 2023','לביא ','שכר',5037,5339.22,5339.22,'עבר להנה"ח','02-04-2024','דווח דיווח יתר על דצמבר. להתקזז בדיווח הקרוב','משרד החינוך','כן','12-20-2023',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','17921223','12-17-2023','2794',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','חלום עתידי בע"מ  ','סנדוויציים לתיאטרון','אריג','פעילות',952,1009.12,1009.12,'עבר להנה"ח','02-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','7921223','01-09-2024','7921223',792,'טיפול בפרט ומניעת נשירה',29,'טיפול בפרט','לביא','שכר עובדים דצמבר 2023','לביא ','שכר',882140,935068.4,935068.4,'עבר להנה"ח','02-04-2024','דווו על דצמבר 948700, להתקזז','משרד החינוך','כן','12-20-2023',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','7931223','01-09-2024','7931223',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר ','לביא','שכר עובדים דצמבר 2023 ','לביא','שכר',102706,108868.36,65058,'עבר להנה"ח','02-04-2024','אלבשאיר תלמידים בלבד','משרד החינוך','כן','03-30-2023',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','17951223','01-09-2024','1161',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','יוזמה עסקית  ','קורסים טכנולוגים נובמבר 2023','עבד','פעילות',18125,19212.5,19212.5,'עבר להנה"ח','02-26-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','17951223','01-09-2024','1162',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','יוזמה עסקית  ','קורסים טכנולוגים דצמבר 2023','עבד','פעילות',77615,82271.9,82271.9,'עבר להנה"ח','02-26-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','14451223','01-09-2024','14451223',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','ספקים מרכז מצטיינים דצמבר 2023','מנון ','פעילות',23399,24802.94,24802.94,'עבר להנה"ח','02-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','37871223','01-09-2024','207',787,'תכנית ישראלית',5,'עסאפיר','עתיד חכם בע"מ  ','תכנית  8 מפגשים תכנית ישראלית','רנאן ','פעילות',106400,112784,112784,'עבר להנה"ח','02-26-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','37871223','01-09-2024','208',787,'תכנית ישראלית',5,'הלן דורון','עתיד חכם בע"מ  ','תכנית  8 מפגשים ','רנאן ','פעילות',148800,157728,157728,'עבר להנה"ח','02-26-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','4451223','01-21-2024','4451223',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','שכר עובדים מרכז מצטיינים דצמבר 2023 ','מנון ','שכר',61506,65196.36,65196.36,'עבר להנה"ח','02-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','37941223','01-21-2024','02/000012',794,'בלתי פורמלי',33,'בתי ספר מנגנים','ברק אלקטרו  ','חליליות והובלה ','עבד','פעילות',3300,3498,3498,'עבר להנה"ח','03-05-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','10-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','17920124','01-21-2024','33',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','סנדוויצים לתיאטרון ','אריג','פעילות',643,681.58,681.58,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','27921223','01-21-2024','2802',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','חלום עתידי בע"מ  ','סנדוויצים לתיאטרון ','אריג','פעילות',1105,1171.3,1171.3,'עבר להנה"ח','03-05-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','27921223','01-21-2024','2804',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','חלום עתידי בע"מ  ','סנדוויצים לתיאטרון ','אריג','פעילות',1105,1171.3,1171.3,'עבר להנה"ח','03-05-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','17940124','01-21-2024','02/000108',794,'בלתי פורמלי',33,'בתי ספר מנגנים','ברק אלקטרו  ','משלוח כלי מוזיקה ל9 בתי ספר ','עבד','פעילות',6150,6519,6519,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930524','05-28-2024','118',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','CC','מתנות לתלמידים ','רנא','פעילות',445,471.7,471.7,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17920124','01-21-2024','31',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','מאפים לתאטרון ','אריג','פעילות',2360,2501.6,2501.6,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','17920124','01-21-2024','2806',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','חלום עתידי בע"מ  ','סנדוויצים לתיאטרון ','אריג','פעילות',866,917.96,917.96,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','9621223','01-21-2024','9621223',963,'בלתי פורמלי',37,'ארגון נוער','לביא','שכר ארגון נוער  דצמבר 2023','בתיה','שכר',305,320.25,320.25,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','9631223','01-21-2024','9631223',963,'בלתי פורמלי',37,'מדצי"ם','לביא','שכר מדצי"ם דצמבר 2023','בתיה','שכר',227320,238686,238686,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','9611223','01-21-2024','9611223',961,'בלתי פורמלי',34,'העצמה','לביא','שכר העצמה דצמבר 2023 ','בתיה','שכר',5658,5940.9,5940.9,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','19631223','01-21-2024','19631223',963,'בלתי פורמלי',37,'מדצי"ם','לביא','ספקים מדצים דצמבר 2023','בתיה','פעילות',31900,33495,33495,'עבר להנה"ח','03-05-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('עירייה','36-23-403','211223','01-22-2024','211223',NULL,'תכנית ישראלית',5,'ערכים','הדפוס הירוק  ','תכנית  הכשרה וחומרי לימוד','רנאן ','פעילות',0,66600,66600,'עבר להנה"ח','02-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-405','21122023','01-22-2024','21122023',787,'תכנית ישראלית',5,'די בונו ','הדפוס הירוק  ','תכנית   הכשרה וחומרי לימוד ','רנאן ','פעילות',0,53040,53040,'עבר להנה"ח','02-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','17930124','01-23-2024','2758',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','קרן הלביא  ','מתנות לתלמידים תחילת שנה ','רנא','פעילות',2808,2976.48,2976.48,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-366','27931223','01-23-2024','2756',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','חלום עתידי בע"מ  ','כיבוד לתלמידים ','רנא','פעילות',483,511.98,511.98,'עבר להנה"ח','03-05-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','09-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','57901223','01-15-2024','3178',790,'ניהול ובקרה',1,'ניהול ובקרה','אדן פרויקטים  ','שכר דצמבר 2023','לביא','שכר',41535,44027.1,0,'עבר להנה"ח','03-31-2024',NULL,'לא',NULL,NULL,2023,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','17930124','01-23-2024','11003',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','אלפא לוגיסטיקה  ','כיבוד לתלמידים ','רנא','פעילות',840,890.4,890.4,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-366','27931223','01-28-2024','301023',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר סטודנטים תואר ראשון','איילון טכנולוגיות  ','הנחיה','ולאא','שכר',2933.33,3109.3298,0,'עבר להנה"ח','03-05-2024',NULL,'לא',NULL,NULL,2023,'תשפ"ד','10-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','17900124','01-31-2024','500204',790,'ניהול ובקרה',1,'ניהול ובקרה','זרעי השמש בע"מ  ','חניה','רבקה','פעילות',2250,2385,2385,'עבר להנה"ח','03-05-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17870124','01-31-2024','10067',787,'תכנית ישראלית',3,'ליווי פדגוגי','לב האקדמיה  ','ליווי חינוכי','נעמה','פעילות',2400,2544,2544,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17920124','01-31-2024','10068',792,'טיפול בפרט ומניעת נשירה',29,'טיפול בפרט','לב האקדמיה  ','ליווי חינוכי','נעמה','פעילות',1500,1590,1590,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17900224','02-04-2024','500209',790,'ניהול ובקרה',1,'ניהול ובקרה','זרעי השמש בע"מ  ','חניה','רבקה','פעילות',2250,2385,2385,'עבר להנה"ח','04-14-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17950124','02-05-2024','310124',795,'חינוך מדעי טכנולוגי',22,'חשיבה חישובית','ספריית האופק  ','חשיבה חישובית  תשפ"ד ','מנון ','פעילות',210363,222984.78,12984.78,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17930124','02-04-2024','3012024',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר סטודנטים תואר ראשון','איילון טכנולוגיות  ','הנחיית קבוצה  דצמבר- ינואר 2023','ולאא','שכר',5000,5300,0,'עבר להנה"ח','03-10-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-366','4450124','02-06-2024','4450124',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','שכר עובדים מרכז מצטיינים ינואר 2023 ','מנון','שכר',39844,42234.64,42234.64,'עבר להנה"ח','02-26-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17950124','02-06-2024','10020',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','הכוכב המזרחי  ','קורסים טכנולוגים ינואר 2024','עבד','פעילות',243417,258022.02,258022.02,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17920824','08-26-2024','9996',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','CC','ציוד','עאידה','פעילות',7578,8032.68,8032.68,'בקשת תשלום','08-26-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17950124','02-06-2024','729871/2',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','חשמל ביתי עיסוויה תיכון בנים 01/2024','עבד','פעילות',12000,12720,12720,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17950124','02-06-2024','641407/2',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','חשמל ביתי  תיכון מותנבי 01/2024','עבד','פעילות',12000,12720,12720,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17950124','02-06-2024','950930/3',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','מנעולנות קידום נוער ינואר 2024','עבד','פעילות',12000,12720,12720,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','9660124','02-06-2024','9660124',966,'בלתי פורמלי',34,'יוניברסיטי','לביא','שכר יוניברסיטי ינואר 2024','בתיה','שכר',3268.7,3432.135,3432.135,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','9620124','02-06-2024','9620124',963,'בלתי פורמלי',37,'ארגון נוער','לביא','שכר ארגון נוער ינואר 2024','בתיה','שכר',102.8,107.94,107.94,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','9630124','02-06-2024','9630124',963,'בלתי פורמלי',37,'מדצי"ם','לביא','שכר מדצים ינואר 2024','בתיה','שכר',217475,228348.75,228348.75,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','9610124','02-06-2024','9610124',961,'בלתי פורמלי',34,'העצמה','לביא','שכר העצמה ינואר 2024','בתיה','שכר',14376.5,15095.325,15095.325,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17900224','02-07-2024','86',790,'ניהול ובקרה',1,'ניהול ובקרה','פיקס פתרונות  ','חניה','לביא','שכר',900,954,0,'עבר להנה"ח','04-14-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','19610124','02-14-2024','19610124',961,'בלתי פורמלי',34,'העצמה','לביא','ספקים העצמה ינואר 2024','בתיה','פעילות',8310,8725.5,8725.5,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','7950124','02-14-2024','7950124',795,'חינוך מדעי טכנולוגי',21,'חדר כושר אלקמה','לביא','שכר עובדים חדר כשר אלקמה ינואר 2024','לביא','שכר',20655,21894.3,0,'עבר להנה"ח','03-10-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','7900124','02-14-2024','7900124',790,'ניהול ובקרה',1,'ניהול ובקרה','לביא','שכר עובדים ינואר 2024','לביא','שכר',114927,121822.62,17556,'עבר להנה"ח','03-10-2024','שכר עבד בלבד','משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','7940124','02-14-2024','7940124',794,'בלתי פורמלי',33,'בתי ספר מנגנים','לביא','שכר עובדים ינואר 2024','לביא','שכר',66240,70214.4,70214.4,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-366','7870124','02-14-2024','7870124',787,'תכנית ישראלית',5,'קלף מנצח תכנית לשיפור הישגים ','לביא','שכר עובדים ינואר 2024','לביא','שכר',6564.15094339623,6958,6958,'עבר להנה"ח','02-26-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','7920124','02-14-2024','7920124',792,'טיפול בפרט ומניעת נשירה',29,'טיפול בפרט','לביא','שכר עובדים ינואר 2024','לביא','שכר',872890,925263.4,925263.4,'עבר להנה"ח','03-05-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','7930124','02-14-2024','7930124',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר ','לביא','שכר עובדים ינואר 2024','לביא','שכר',97816.4716981132,103685.46,75868,'עבר להנה"ח','03-10-2024','אלבשאיר תלמידים בלבד','משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910224','02-14-2024','1305',791,'עברית ושפת אם',16,'כל טכנולוגי ללימוד עברית ','רשת גלקטיק  ','כיבוד להכשרת מורים על אפלקציה','מוריס','פעילות',1605,1701.3,1701.3,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17920224','02-14-2024','38',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידי תאטרון ','עבד','פעילות',760,805.6,805.6,'עבר להנה"ח','04-14-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17920224','02-14-2024','37',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידי תאטרון ','עאידה','פעילות',1053,1116.18,1116.18,'עבר להנה"ח','04-14-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17920224','02-14-2024','35',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידי תאטרון ','עאידה','פעילות',982,1040.92,1040.92,'עבר להנה"ח','04-14-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17920224','02-14-2024','34',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידי תאטרון ','עאידה','פעילות',819,868.14,868.14,'עבר להנה"ח','04-14-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','57900124','02-22-2024','3181',790,'ניהול ובקרה',1,'ניהול ובקרה','אדן פרויקטים  ','שכר ינואר 2024','לביא','שכר',41535,44027.1,0,'עבר להנה"ח','03-10-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','57901123','02-22-2024','3175',790,'ניהול ובקרה',1,'ניהול ובקרה','אדן פרויקטים  ','שכר נובמבר 2023','לביא','שכר',41535,44027.1,0,'עבר להנה"ח','03-05-2024',NULL,'לא',NULL,NULL,2023,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','17930224','02-25-2024','250224',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','מערב מחשבים  ','סדנת קרמירה לרכזים ','רנא','פעילות',1600,1696,1696,'עבר להנה"ח','04-14-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910224','02-25-2024','40060',791,'עברית ושפת אם',12,'אולפנים בתוך שעות הלימודים','סופטאפ  ','ליווי פדגוגי-תכנית הוראת עברית במזרח ירושלים 1/24','הראל','שכר',23400,24804,24804,'עבר להנה"ח','04-04-2024','לבדוק האם אפשר לדווח למשרד החינוך','משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910224','02-25-2024','40061',791,'עברית ושפת אם',17,'מרכז שפות','סופטאפ  ','לוייו פדגוגי מרכז שפות 01/ 24','הראל','שכר',17550,18603,18603,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910224','02-25-2024','40062',791,'עברית ושפת אם',12,'אולפנים בתוך שעות הלימודים','סופטאפ  ','ליווי פדגוגי הוראת עברית מזרח ירושלים 2/24','הראל','שכר',23400,24804,24804,'עבר להנה"ח','04-04-2024','לבדוק האם אפשר לדווח למשרד החינוך','משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910224','02-25-2024','40063',791,'עברית ושפת אם',17,'מרכז שפות ','סופטאפ  ','ליווי פדגוגי מרכז שפות 02/24','הראל','שכר',17550,18603,18603,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17900224','02-29-2024','1042',790,'ניהול ובקרה',1,'אסטרטגיה','נחשוני פתרונות  ','שכר נובמבר 2023','לביא','שכר',5850,6201,0,'עבר להנה"ח','04-14-2024',NULL,'לא',NULL,NULL,2023,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','17900224','02-29-2024','1044',790,'ניהול ובקרה',1,'אסטרטגיה','נחשוני פתרונות  ','שכר דצמבר 2023','לביא','שכר',5850,6201,0,'עבר להנה"ח','04-14-2024',NULL,'לא',NULL,NULL,2023,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-29-2024','22917',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','CC','אוכל ','רנא','פעילות',17,18.02,18.02,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17930224','02-29-2024','1825',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','תבונה טכנולוגית  ','הסעת תלמידים 17/12','יוסי','פעילות',1029.6,1091.376,1091.376,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910224','02-29-2024','19224',791,'עברית ושפת אם',17,'מרכז שפות','הרמוניה עסקית  ','כיבוד לתלמידים ','אריג','פעילות',391,414.46,414.46,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910224','02-29-2024','20224',791,'עברית ושפת אם',17,'מרכז שפות','הרמוניה עסקית  ','כיבוד לתלמידים ','אריג','פעילות',262,277.72,277.72,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910224','02-29-2024','25224',791,'עברית ושפת אם',17,'מרכז שפות ','הרמוניה עסקית  ','כיבוד לתלמידים ','אריג','פעילות',385,408.1,408.1,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17950224','03-04-2024','10021',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','הכוכב המזרחי  ','קורסים טכנולוגים פברואר 2024','לביא','פעילות',253246,268440.76,268440.76,'עבר להנה"ח','04-16-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17950224','03-04-2024','950930/4',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','מנעולנות קידום נוער פברואר 2024','לביא','פעילות',16000,16960,16960,'עבר להנה"ח','04-16-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17950224','03-04-2024','641407/3',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','חשמל ביתי  תיכון מותנבי 02/2024','לביא','פעילות',12000,12720,12720,'עבר להנה"ח','04-16-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17950224','03-04-2024','729871/3',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','חשמל ביתי עיסוויה תיכון בנים 02/2024','לביא','פעילות',12000,12720,12720,'עבר להנה"ח','04-16-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','7900224','03-04-2024','7900224',790,'ניהול ובקרה',1,'ניהול ובקרה','לביא','שכר עובדים פברואר 2024','לביא','פעילות',115689.5,122630.87,122630.87,'עבר להנה"ח','04-04-2024','שכר עבד בלבד','משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','7870224','03-04-2024','7870224',787,'תכנית ישראלית',5,'קלף נמצח ','לביא','שכר עובדים פברואר 2024','לביא','שכר',20534,21766.04,21766.04,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','7930224','03-04-2024','7930224',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר ','לביא','שכר עובדים פברואר 2024','לביא','שכר',135209.6,143322.176,86011,'עבר להנה"ח','04-08-2024','אלבשאיר תלמידים בלבד','משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','7920224','03-04-2024','7920224',792,'טיפול בפרט ומניעת נשירה',29,'טיפול בפרט','לביא','שכר עובדים פברואר 2024','לביא','שכר',853813.7,905042.522,905042.522,'עבר להנה"ח','04-08-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','7940224','03-04-2024','7940224',794,'בלתי פורמלי',33,'בתי ספר מנגנים','לביא','שכר עובדים פברואר 2024','לביא','שכר',67340.49,71380.9194,71380.9194,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','7910224','03-05-2024','7910224',791,'עברית ושפת אם',17,'מרכז שפות','לביא','שכר מנהלת מרכז שפות פברואר 24','לביא','שכר',7325,7764.5,7764.5,'עבר להנה"ח','04-08-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','19630224','03-06-2024','19630224',963,'בלתי פורמלי',37,'מדצי"ם','לביא','ספקים מדצים פברואר 2024','בתיה','פעילות',43000,45150,45150,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','19660224','03-06-2024','19660224',966,'בלתי פורמלי',34,'יוניברסיטי','לביא','ספקים יוניברסטי פברואר 2024','בתיה','פעילות',1192,1251.6,1251.6,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','9610224','03-06-2024','9610224',961,'בלתי פורמלי',34,'העצמה','לביא','שכר העצמה פברואר 2024','בתיה','שכר',21688.6,22773.03,22773.03,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','9620224','03-06-2024','9620224',963,'בלתי פורמלי',37,'ארגון נוער','לביא','שכר ארגון ונוער 2024','בתיה','שכר',1608,1688.4,1688.4,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','9630224','03-06-2024','9630224',963,'בלתי פורמלי',37,'מדצי"ם','לביא','שכר מדצ"ים פברואר 2024','בתיה','שכר',239462.5,251435.625,251435.625,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','9660224','03-06-2024','9660224',966,'בלתי פורמלי',34,'יוניברסיטי','לביא','שכר עובדים יוניברסטי פברואר 2024','בתיה','שכר',4151,4358.55,4358.55,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17940224','03-07-2024','38',794,'בלתי פורמלי',38,'קונסרבטוריון','המרכז המוזיקלי  ','ניהול הקונסרבטוריון לחדוש  דצמבר 2023','ברק','פעילות',117247,124281.82,124281.82,'עבר להנה"ח','04-14-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17940224','03-07-2024','39',794,'בלתי פורמלי',38,'קונסרבטוריון','המרכז המוזיקלי  ','ניהול הקונסרבטוריון לחדוש ינואר 2024','ברק','פעילות',108261,114756.66,114756.66,'עבר להנה"ח','04-14-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','7950224','03-11-2024','7950224',795,'חינוך מדעי טכנולוגי',21,'חדר כושר אלקמה','לביא','שכר עובדים חדר כשר אלקמה פברואר 2024','לביא','שכר',20853,22104.18,0,'עבר להנה"ח','04-04-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17930324','03-12-2024','IN240000321',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','בוטיק הים  ','סיור בספרייה הלאומית ','רנא','פעילות',2016,2136.96,2136.96,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17920324','03-12-2024','10070',792,'טיפול בפרט ומניעת נשירה',29,'טיפול בפרט','לב האקדמיה  ','ליווי חינוכי','נעמה','פעילות',1800,1908,1908,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17940324','03-12-2024','474',794,'בלתי פורמלי',33,'בתי ספר מנגנים','דרכים מתקדמות  ','פעילות עבור בית ספר מנגן מרץ 2024','עבד','פעילות',3744,3968.64,3968.64,'עבר להנה"ח','05-28-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17930324','03-12-2024','60324',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','אלפא לוגיסטיקה  ','כיבוד לתלמידים וצוות ','אחמד','פעילות',2120,2247.2,0,'עבר להנה"ח','05-12-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17920324','03-12-2024','41',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידים ','עאידה','פעילות',772,818.32,818.32,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17930324','03-12-2024','177',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','ניצוץ רעיונות  ','הרצאה לתלמידים על שוק העבודה ','רנא','פעילות',1300,1378,1378,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17930324','03-12-2024','400042',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','גפן שירותים כלליים  ','כיבוד לתלמידים ','רנא','פעילות',190,201.4,201.4,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17900224','03-17-2024','88',790,'ניהול ובקרה',1,'ניהול ובקרה','פיקס פתרונות  ','חניה','לביא','שכר',900,954,0,'עבר להנה"ח','04-14-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','19610224','03-18-2024','19610224',961,'בלתי פורמלי',34,'העצמה','לביא','ספקים העצמה פברואר 2024','בתיה','פעילות',477059,500911.95,500911.95,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17950324','03-18-2024','180324',795,'חינוך מדעי טכנולוגי',20,'מעבדות ניידות ','ספריית האופק  ','מעבדות ניידות מנונבמר עד מרץ 2024 ','מנון','פעילות',83300,88298,88298,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','14450224','03-20-2024','14450224',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','ספקים מרכז מצטיינים פברואר 2024','מנון','פעילות',24182.86,25633.8316,25633.8316,'עבר להנה"ח','04-16-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-18-2024','80724',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','CC','השכרת אוהל זוגי +שק שינה +כרית לימי שיא במדבר ','אחמד','פעילות',42000,44520,44520,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910224','02-25-2024','376010486',791,'עברית ושפת אם',17,'מרכז שפות ','דפוס העתיד  ','מים קפה וחדש פעמי ','אריג','פעילות',147,155.82,155.82,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910224','02-25-2024','190224',791,'עברית ושפת אם',17,'מרכז שפות ','הרמוניה עסקית  ','מיץ ועוגות לתלמידי מרכז שפות ','אריג','פעילות',144.7,153.382,153.382,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910224','02-25-2024','150224',791,'עברית ושפת אם',17,'מרכז שפות ','הרמוניה עסקית  ','חד פעמי, חלב , קפה ','אריג','פעילות',112.9,119.674,119.674,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910224','02-25-2024','72',791,'עברית ושפת אם',17,'מרכז שפות ','תאטרון המגדל  ','ציוד כתיבה למרכז שפות ','אריג','פעילות',137,145.22,145.22,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910224','02-25-2024','74',791,'עברית ושפת אם',17,'מרכז שפות ','תאטרון המגדל  ','תגי שמות לתלמידי מרכז שפות ','אריג','פעילות',150,157.5,157.5,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910224','02-25-2024','76',791,'עברית ושפת אם',17,'מרכז שפות ','תאטרון המגדל  ','ציוד מרכז שפות ','אריג','פעילות',60,63.6,63.6,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-18-2024','80724',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','CC','אחרוחת בוקר ,וצהריים , ציוד הובלה לימי שיא במדבר ','אחמד','פעילות',19260,20415.6,20415.6,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17930324','03-21-2024','290224',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר סטודנטים תואר ראשון','איילון טכנולוגיות  ','הנחיית קבוצות מפברואר עד מרץ 2024','ולאא','שכר',5000,5300,0,'עבר להנה"ח','05-12-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17920324','03-21-2024','39',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידי תאטרון ','עאידה','פעילות',795,842.7,842.7,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17870424','03-21-2024','IN244000110',787,'תכנית ישראלית',3,'ליווי פדגוגי','ספריית הענן  ','ליווי בתי ספר ינואר -פברואר 2024','אמיר','פעילות',190500,201930,201930,'עבר להנה"ח','06-05-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','11-07-2024','7112024',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר עזריאלי','CC','ציוד ','אחמד','פעילות',3888,4121.28,4121.28,'בקשת תשלום','11-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ה','11-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17930324','03-26-2024','68',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','תאטרון המגדל  ','ציוד משרדי ','רנא','פעילות',500,530,530,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17930324','03-26-2024','68',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','תאטרון המגדל  ','ציוד משרדי ','רנא','פעילות',125,132.5,132.5,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17930824','09-08-2024','10947262',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים ','CC','כיבוד','רנא','פעילות',97.6,103.456,103.456,'בקשת תשלום','09-08-2024',NULL,'משרד החינוך','לא',NULL,2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17930324','03-26-2024','260324',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים',' SUPERMARKET ','מים ,נס ועוגות ','רנא','פעילות',72.8,77.168,77.168,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910324','03-26-2024','40065',791,'עברית ושפת אם',17,'מרכז שפות','סופטאפ  ','ליווי פדגוגי -מרכז שפות מרץ 2024','הראל','שכר',17550,18603,18603,'עבר להנה"ח','05-02-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910324','03-26-2024','40064',791,'עברית ושפת אם',12,'אולפנים בתוך שעות הלימודים','סופטאפ  ','ליווי פדגוגי -תכנית הוראת עברית במזרח ירושלים מרץ 24','הראל','שכר',23400,24804,24804,'עבר להנה"ח','05-02-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17870324','03-26-2024','50003',787,'תכנית ישראלית',5,'בית אלחכמה ','מודול פתרונות  ','הדספת חומרי לימוד , טקסטים לתלמידים  ','מלחם ','פעילות',4499.8,4769.788,4769.788,'עבר להנה"ח','05-28-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17870324','03-27-2024','51',787,'תכנית ישראלית',5,'קלף מנצח ','אופק ירוק  ','ארוחת שבירת צום רמדאן 3/24','פואד','פעילות',8000,8480,8480,'עבר להנה"ח','05-28-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930524','05-28-2024','10324',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים',' SUPERMARKET ','חד פעמי','רנא','פעילות',86,91.16,91.16,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910324','04-03-2024','233000026',791,'עברית ושפת אם',16,'כל טכנולוגי ללימוד עברית ','טוקספייס בע"מ  ','מערכת מקוונת לתמיכה בלימוד השפה העברית למוסדות במזרח ירושלים','הראל','פעילות',37440,39686.4,39686.4,'עבר להנה"ח','05-02-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'על חשבון הכנסות אחרות ','04-03-2024','233000025',791,'עברית ושפת אם',16,'כל טכנולוגי ללימוד עברית ','טוקספייס בע"מ  ','10% מהעלות החד פעמית עבור מסירה הדרכה והטמעה של המערכת ','הראל','פעילות',25155,26664.3,26664.3,'עבר להנה"ח','05-27-2024',NULL,'ראסל-ברי','לא',NULL,2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17950324','03-31-2024','641407/4',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','חשמל ביתי תכיון מותנבי 03/24','עבד','פעילות',8000,8480,8480,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17950324','03-31-2024','729871/4',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','חשמל ביתי עיסוויה תיכון בנים 03/24','עבד','פעילות',16000,16960,16960,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17950324','03-31-2024','950930/5',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','מנעולנות קידום נוער 03/24','עבד','פעילות',8000,8480,8480,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17870324','03-31-2024','307',787,'תכנית ישראלית',5,'עסאפיר','עתיד חכם בע"מ  ','8 מפגשים תכנית  תכנית ישראלית ','רנאן ','פעילות',89600,94976,94976,'עבר להנה"ח','05-28-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17870324','03-31-2024','308',787,'תכנית ישראלית',18,'עסאפיר','עתיד חכם בע"מ  ','8 מפגשים תכנית  תכנית פלסטינית  ','רנאן ','פעילות',16800,17808,17808,'עבר להנה"ח','05-28-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17870324','03-31-2024','304',787,'תכנית ישראלית',5,'הלן דורון','עתיד חכם בע"מ  ','8 מפגשים לקבוצה תכנית  ','רנאן ','פעילות',110400,117024,117024,'עבר להנה"ח','05-28-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910324','03-31-2024','310324',791,'עברית ושפת אם',17,'מרכז שפות ','הרמוניה עסקית  ','ציוד למרכז שפות ','אריג','פעילות',80,84.8,84.8,'עבר להנה"ח','05-02-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910324','03-31-2024','310324',791,'עברית ושפת אם',17,'מרכז שפות ','הרמוניה עסקית  ','כיבוד לתלמידים ','אריג','פעילות',490,519.4,519.4,'עבר להנה"ח','05-02-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910324','03-31-2024','310324',791,'עברית ושפת אם',17,'מרכז שפות ','הרמוניה עסקית  ','כיבוד לתלמידים ','אריג','פעילות',348,368.88,368.88,'עבר להנה"ח','05-02-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910324','03-31-2024','99',791,'עברית ושפת אם',17,'מרכז שפות ','תאטרון המגדל  ','תגים לתלמידים ','אריג','פעילות',150,159,159,'עבר להנה"ח','05-02-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910324','03-31-2024','100',791,'עברית ושפת אם',17,'מרכז שפות ','תאטרון המגדל  ','צילומים צסעוניים +נייר ','אריג','פעילות',45,47.7,47.7,'עבר להנה"ח','05-02-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930524','05-28-2024','25424',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים',' SUPERMARKET ','כיבוד ','רנא','פעילות',49,51.94,51.94,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-29-2024','30724',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים',' SUPERMARKET ','חלב וכוסות ','רנא','פעילות',20.9,22.154,22.154,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910324','04-01-2024','681',791,'עברית ושפת אם',17,'מרכז שפות ','עלים בע"מ  ','מתנות לתלמידי מרכז שפות ','אריג','פעילות',2100,2226,2226,'עבר להנה"ח','05-02-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17950324','04-03-2024','11',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','יוזמה עסקית  ','קורסים טכנולוגים 03/24 ','עבד','פעילות',67555,71608.3,71608.3,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17950324','04-03-2024','12',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','יוזמה עסקית  ','קורסים טכנולוגים 02/24 ','עבד','פעילות',86322,91501.32,91501.32,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('עירייה','36-23-405','002/2024','03-24-2024','002/2024',NULL,'תכנית ישראלית',5,'די בונו ','הדפוס הירוק  ','מפגשי תכנית 12/23 עד 3/24','רנאן','פעילות',0,140160,140160,'עבר להנה"ח','05-02-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('עירייה','36-23-403','001/2024','03-24-2024','001/2024',NULL,'תכנית ישראלית',5,'ערכים','הדפוס הירוק  ','מפגשי תכנית  12/23 עד 3/24','רנאן ','פעילות',0,227400,227400,'עבר להנה"ח','04-07-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-29-2024','100724',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים',' SUPERMARKET ','חלב קפה וסכו"ם ','רנא','פעילות',127.7,135.362,135.362,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930624','07-01-2024','15805',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','OFFICE','הדפסה צבוענית ','רנא','פעילות',150,159,159,'עבר להנה"ח','08-04-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17920424','04-03-2024','40',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידי תאטרון ','עאידה','פעילות',538,570.28,570.28,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17920424','04-03-2024','42',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידי תאטרון ','עאידה','פעילות',889,942.34,942.34,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930624','07-01-2024','15815',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','OFFICE','הדפסות ','רנא','פעילות',110,116.6,116.6,'עבר להנה"ח','08-04-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17870424','04-04-2024','50014',787,'תכנית ישראלית',5,'בית אלחכמה ','מודול פתרונות  ','סדנה מעשית על ידי אמנית מספר משתתפים 45 ','מלחם ','פעילות',6187,6558.22,6558.22,'עבר להנה"ח','06-05-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17940324','04-07-2024','40',794,'בלתי פורמלי',38,'קונסרבטוריון','המרכז המוזיקלי  ','ניהול הקונסרבטוריון לחודש פברואר 2024','ברק','פעילות',112552,119305.12,119305.12,'עבר להנה"ח','05-28-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','1790324','04-07-2024','91',790,'ניהול ובקרה',1,'ניהול ובקרה','פיקס פתרונות  ','חניה','לביא','שכר',900,954,0,'עבר להנה"ח','05-20-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','1790324','04-07-2024','90',790,'ניהול ובקרה',1,'ניהול ובקרה','פיקס פתרונות  ','חניה','לביא','שכר',900,954,0,'עבר להנה"ח','05-20-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17870424','04-14-2024','10962',787,'תכנית ישראלית',3,'ליווי פדגוגי','שחר מחשבים  ','שעות תגבור חורף פברואר מרץ 24','אורלי','פעילות',143404.56,152008.8336,152008.8336,'עבר להנה"ח','06-05-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','57900224','03-01-2024','3183',790,'ניהול ובקרה',1,'ניהול ובקרה','אדן פרויקטים  ','שכר פברואר 2024','לביא','שכר',41535,44027.1,0,'עבר להנה"ח','06-05-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','57900324','04-01-2024','3186',790,'ניהול ובקרה',1,'ניהול ובקרה','אדן פרויקטים  ','שכר מרץ 2024','לביא','שכר',41535,44027.1,0,'עבר להנה"ח','06-05-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','9610324','04-16-2024','9610324',961,'בלתי פורמלי',34,'העצמה','לביא','שכר העצמה מרץ 2024','בתיה','שכר',20000.6,21000.63,21000.6,'עבר להנה"ח','05-22-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','9620324','04-16-2024','9620324',963,'בלתי פורמלי',37,'ארגון נוער','לביא','שכר ארגון ונוער מרץ 2024','בתיה','שכר',-135.9,-142.695,-142.695,'עבר להנה"ח','05-22-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','9660324','04-16-2024','9660324',966,'בלתי פורמלי',34,'יוניברסיטי','לביא','שכר עובדים יונברסיטי מרץ 2024 ','בתיה','שכר',4716.6,4952.43,4952.43,'עבר להנה"ח','05-22-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','9630324','04-16-2024','9630324',963,'בלתי פורמלי',37,'מדצי"ם','לביא','שכר מדצ"ים מרץ 2024','בתיה','שכר',288965,303413.25,303413.25,'עבר להנה"ח','05-22-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','4450324','04-16-2024','4450324',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','שכר עובדים מרכז מצטיינים מרץ 2024','מנון','שכר',70975.15,75233.659,75233.659,'עבר להנה"ח','05-22-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','14450324','04-16-2024','14450324',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','ספקים מרכז מצטיינים מרץ 2024','מנון','פעילות',32672,34632.32,34632.32,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','7910324','04-17-2024','7910324',791,'עברית ושפת אם',17,'מרכז שפות ','לביא','ספקים מרכז מצטיינים מרץ 2024','לביא','שכר',11240.7,11915.142,11915.142,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','7940324','04-17-2024','7940324',794,'בלתי פורמלי',33,'בתי ספר מנגנים','לביא','שכר עובדים בית ספר מנגן מרץ 24','לביא','שכר',76129.2452830189,80697,80697,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','7870324','04-17-2024','7870324',787,'תכנית ישראלית',5,'קלף מנצח ','לביא','שכר עובדים מרץ 24','לביא','שכר',17899.0566037736,18973,18973,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','7950324','04-17-2024','7950324',795,'חינוך מדעי טכנולוגי',21,'חדר כושר אלקמה','לביא','שכר עובדים מרץ 24','לביא','שכר',22839.2075471698,24209.56,0,'עבר להנה"ח','05-12-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','7920324','04-17-2024','7920324',792,'טיפול בפרט ומניעת נשירה',29,'טיפול בפרט','לביא','שכר עובדים מרץ 2024','לביא','שכר',929906.603773585,985701,985701,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17930424','04-30-2024','240324',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','הרגע שלך בע"מ  ','השכרת כיסאות , הספקה וכיבוד ','רנא','פעילות',4400,4664,4664,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-30-2024','100724',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','SMART','תשלום עבור שירותי הודעות וואטספ','רנא','פעילות',2246,2380.76,2380.76,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17910424','04-30-2024','40066',791,'עברית ושפת אם',12,'אולפנים בתוך שעות הלימודים','סופטאפ  ','ליווי פדגוגי תכנית הוראת עברית אפריל 24','הראל','שכר',23400,24804,24804,'עבר להנה"ח','06-10-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17910424','04-30-2024','40067',791,'עברית ושפת אם',17,'מרכז שפות','סופטאפ  ','ליווי פדגוגי- מרכז שפות 04/24','הראל','שכר',7020,7441.2,7441.2,'עבר להנה"ח','06-10-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17930424','04-30-2024','30324',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר סטודנטים תואר ראשון','איילון טכנולוגיות  ','הנחיה','ולאא','שכר',5000,5300,0,'עבר להנה"ח','06-30-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17920424','04-30-2024','45',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידים 04/24','עאידה','פעילות',614,650.84,650.84,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17920424','04-30-2024','46',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידים 04/24','עאידה','פעילות',702,744.12,744.12,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','10-27-2024','40216',790,'ניהול ובקרה',1,'ניהול ובקרה','SMART','תשלום 1/4 תשפ"ה ','אולג','פעילות',24570,26044.2,26044.2,'בקשת תשלום','10-27-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ה','10-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17910424','04-30-2024','210424',791,'עברית ושפת אם',17,'מרכז שפות ','הרמוניה עסקית  ','כיבוד לתלמידים ','אריג','פעילות',375.9,398.454,398.454,'עבר להנה"ח','06-10-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17910424','04-30-2024','220424',791,'עברית ושפת אם',17,'מרכז שפות ','הרמוניה עסקית  ','כיבוד לתלמידים ','אריג','פעילות',490.8,520.248,520.248,'עבר להנה"ח','06-10-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17910424','04-30-2024','230424',791,'עברית ושפת אם',17,'מרכז שפות ','הרמוניה עסקית  ','כיבוד לתלמידים ','אריג','פעילות',398.3,422.198,422.198,'עבר להנה"ח','06-10-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17870424','04-10-2024','IN244000300',787,'תכנית ישראלית',3,'ליווי פדגוגי','ספריית הענן  ','ליווי בתי ספר מרץ 2024','אמיר','פעילות',142800,151368,151368,'עבר להנה"ח','06-05-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17930424','05-02-2024','2828',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','חלום עתידי בע"מ  ','כיבוד לתלמידים וצוות אלבשאיר ','רנא','פעילות',442,468.52,468.52,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17930824','09-02-2024','180824',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר עזריאלי','SMART','תעודות ומתנות ','אחמד','פעילות',3300,3498,3498,'בקשת תשלום','09-02-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','10-27-2024','151024',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים ','SMART','ציוד לתלמידים ','רנא','פעילות',9560,10133.6,10133.6,'בקשת תשלום','10-27-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','10-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17900624','07-04-2024','13524',790,'ניהול ובקרה',1,'ניהול ובקרה','SMART','תשלום עבור סקר הורים ','לביא','פעילות',3448.8,3655.728,0,'עבר להנה"ח','08-18-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17910524','05-28-2024','261',791,'עברית ושפת אם',17,'מרכז שפות','תקשורת','מקרנים ורמקולים למרכז שפות','אריג','פעילות',3014,3194.84,3194.84,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17870424','05-05-2024','11017',787,'תכנית ישראלית',3,'ליווי פדגוגי','שחר מחשבים  ','שעות תגבור חורף אפריל 24','אורלי','פעילות',12645.36,13404.0816,13404.0816,'עבר להנה"ח','06-05-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17910424','05-05-2024','11018',791,'עברית ושפת אם',12,'אולפנים בתוך שעות הלימודים','שחר מחשבים  ','הכנה לבגרות בעברית דבורה מרץ אפריל 24  ','אורלי','פעילות',65819.5,69768.67,69768.67,'עבר להנה"ח','06-10-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','7900324','04-03-2024','7900324',790,'ניהול ובקרה',1,'ניהול ובקרה','לביא','שכר עובדים מרץ 24','לביא','שכר',118487.6,125596.856,18361.35,'עבר להנה"ח','05-22-2024','שכר עבד בלבד','משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-21-2024','210724',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','גאונים','שני קורסים פסיכומטרי תכנית אלבשאיר תשפד ','רנא','פעילות',121300,128578,128578,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','7930324','04-03-2024','7930324',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר ','לביא','שכר עובדים 03/24','לביא','שכר',131794.5,139702.17,88349,'עבר להנה"ח','05-22-2024','אלבשאיר תלמידים בלבד','משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910724','07-28-2024','250724',791,'עברית ושפת אם',17,'מרכז שפות ','גאונים','פעילות קיץ במרכז שפות בשפה העברית לכיתות ד-ה תשפד','נבילה','פעילות',495202,524914.12,524914.12,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17950424','05-06-2024','729871/5',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','חשמל ביתי עיסוויה תיכון בנים 04/24','עבד','פעילות',12000,12720,12720,'עבר להנה"ח','07-11-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17950424','05-06-2024','950930/6',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','מנעולנות קידום נוער 04/24','עבד','פעילות',4000,4240,4240,'עבר להנה"ח','07-11-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17950424','05-07-2024','18',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','יוזמה עסקית  ','קורסים טכנולוגים 04/24','עבד','פעילות',12501,13251.06,13251.06,'עבר להנה"ח','07-11-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17920524','05-08-2024','47',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידים מאי 24','עאידה','פעילות',579,613.74,613.74,'עבר להנה"ח','07-16-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17950524','05-08-2024','02/001119',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים',' יזמויות ע.ג               ','מתנות לתלמידים בכנס תוצר טכנולוגי ','עבד','פעילות',3150,3339,3339,'עבר להנה"ח','09-25-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','19630324','05-08-2024','19630324',963,'בלתי פורמלי',37,'מדצי"ם','לביא','ספקים מדצים 03/24','בתיה','פעילות',55000,57750,57750,'עבר להנה"ח','05-22-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','19610324','05-08-2024','19610324',961,'בלתי פורמלי',34,'העצמה','לביא','ספקים העצמה 03/24','בתיה','פעילות',674545.89,708273.1845,708273.1845,'עבר להנה"ח','05-22-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','14450424','05-12-2024','14550424',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','ספקים מרכז מצטיינים אפריל 2024','מנון','פעילות',3380,3582.8,3582.8,'עבר להנה"ח','05-28-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-408','17910424','05-12-2024','500217',790,'ניהול ובקרה',1,'ניהול ובקרה','זרעי השמש בע"מ  ','חניה','לביא','פעילות',6750,7155,7155,'עבר להנה"ח','06-23-2024','לא','משרד החינוך',NULL,NULL,2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17910824','08-15-2024','14824',791,'עברית ושפת אם',17,'מרכז שפות ','גאונים','קורס הכנה ללימודי שפה עברית והכנה ליעל למועמדי מכללת עזראלי 24','נבילה','פעילות',95976,101734.56,101734.56,'בקשת תשלום','08-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17940524','05-16-2024','41',794,'בלתי פורמלי',38,'קונסרבטוריון','המרכז המוזיקלי  ','ניהול הקונסרבטוריון לחודש מרץ 2024','ברק','פעילות',112502,119252.12,119252.12,'עבר להנה"ח','07-11-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17940524','05-16-2024','42',794,'בלתי פורמלי',38,'קונסרבטוריון','המרכז המוזיקלי  ','ניהול הקונסרבטוריון לחודש אפריל 2024','ברק','פעילות',107477,113925.62,113925.62,'עבר להנה"ח','07-11-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','4450224','03-20-2024','4450224',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','שכר עובדים מרכז מצטיינים פברואר 2024','מנון','שכר',77753,82418.18,82418.18,'עבר להנה"ח','04-16-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','7870424','05-16-2024','7870424',787,'תכנית ישראלית',5,'קלף מנצח תכנית לשיפור הישגים ','לביא','שכר עובדים אפריל 2023','לביא','שכר',18507.5471698113,19618,19618,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','7950424','05-16-2024','7950224',795,'חינוך מדעי טכנולוגי',21,'חדר כושר אלקמה','לביא','שכר עובדים אפריל 2024','לביא','שכר',20537.7358490566,21770,0,'עבר להנה"ח','07-16-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','7940424','05-16-2024','7940424',794,'בלתי פורמלי',33,'בתי ספר מנגנים','לביא','שכר עובדים אפריל 2024','לביא','שכר',68429.2452830189,72535,72535,'עבר להנה"ח','07-10-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','7930424','05-16-2024','7930424',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר ','לביא','שכר עובדים אפריל 2024','לביא','שכר',109708.386792453,116290.89,75331,'עבר להנה"ח','07-11-2024','אלבשאיר תלמידים בלבד','משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','7920424','05-16-2024','7920424',792,'טיפול בפרט ומניעת נשירה',29,'טיפול בפרט','לביא','שכר עובדים אפריל 2024','לביא','שכר',861760.849056604,913466.5,913466.5,'עבר להנה"ח','09-25-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','7900424','05-16-2024','790424',790,'ניהול ובקרה',1,'ניהול ובקרה','לביא','שכר עובדים אפריל 2024','לביא','שכר',111858.490566038,118570,17556,'עבר להנה"ח','07-11-2024','שכר של עבד בלבד','משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','7850324','05-16-2024','7850324',787,'תכנית ישראלית',6,'חיזוק לימוד ומעטפת במעבר לתכנית ישראלית','לביא','שכר עובדים מרץ 2024','לביא','שכר',59176.4150943396,62727,62727,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','7850424','05-16-2024','7850424',787,'תכנית ישראלית',6,'חיזוק לימוד ומעטפת במעבר לתכנית ישראלית','לביא','שכר עובדים אפריל 2024','לביא','שכר',56423.5849056604,59809,59809,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17930824','08-27-2024','260824',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים ','גאונים','קורס פסיכומטרי תלמידי אלבשאיר','רנא','פעילות',78700,83422,83422,'בקשת תשלום','08-27-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17910524','05-28-2024','22524',791,'עברית ושפת אם',17,'מרכז שפות','הרמוניה עסקית  ','כיבוד לתלמידים','אריג','פעילות',486,515.16,515.16,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17910524','05-28-2024','21524',791,'עברית ושפת אם',17,'מרכז שפות','הרמוניה עסקית  ','כיבוד לתלמידים','אריג','פעילות',486,515.16,515.16,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17910524','05-28-2024','20524',791,'עברית ושפת אם',17,'מרכז שפות','הרמוניה עסקית  ','כיבוד לתלמידים','אריג','פעילות',459.8,487.388,487.388,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17910524','05-28-2024','18524',791,'עברית ושפת אם',17,'מרכז שפות','הרמוניה עסקית  ','כיבוד לתלמידים','אריג','פעילות',463,490.78,490.78,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17910524','05-28-2024','13524',791,'עברית ושפת אם',17,'מרכז שפות','הרמוניה עסקית  ','כיבוד לתלמידים','אריג','פעילות',462.7,490.462,490.462,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17910524','05-28-2024','11524',791,'עברית ושפת אם',17,'מרכז שפות','הרמוניה עסקית  ','כיבוד לתלמידים','אריג','פעילות',451.5,478.59,478.59,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17910524','05-28-2024','80524',791,'עברית ושפת אם',17,'מרכז שפות','הרמוניה עסקית  ','כיבוד לתלמידים','אריג','פעילות',481.6,510.496,510.496,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17910524','05-28-2024','60524',791,'עברית ושפת אם',17,'מרכז שפות','הרמוניה עסקית  ','כיבוד לתלמידים','אריג','פעילות',462.5,490.25,490.25,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930524','05-28-2024','30424',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר סטודנטים תואר ראשון','איילון טכנולוגיות  ','הנחית קבוצות אפריל-מאי 2024','ולאא','שכר',5000,5300,0,'עבר להנה"ח','06-30-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17920824','08-27-2024','1683',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','פעלויות מטריפות','ODT לתלמידי התאטרון  ','אריג','פעילות',42000,44520,44520,'בקשת תשלום','08-27-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17920824','09-02-2024','1682',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','פעלויות מטריפות','מסלול הליכה ופעילות בטבע ','אריג','פעילות',35000,37100,37100,'בקשת תשלום','09-02-2024',NULL,'משרד החינוך','כן ','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930524','05-28-2024','1933',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','תבונה טכנולוגית  ','הסעת תלמידים ','רנא','פעילות',1673,1773.38,1773.38,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930524','05-28-2024','38',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','הנחיה והדרכה','תכנית הכשרה לסטודמטים  מכללת עזראלי ','אחמד','פעילות',14215.5,15068.43,15068.43,'עבר להנה"ח','06-30-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930524','05-28-2024','43',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','הנחיה והדרכה','סדנת חשיפה לעולם ההיטק','אחמד','פעילות',2340,2480.4,2480.4,'עבר להנה"ח','06-30-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930524','05-28-2024','400052',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים',' דיאפה בע"מ                ','כיבוד לתלמידים ','רנא','פעילות',486,515.16,515.16,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930524','05-28-2024','1307',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים',' קבוצת טורי קידס           ','ציוד משרדי ','רנא','פעילות',28,29.68,29.68,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930624','07-01-2024','49',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','הנחיה והדרכה','סדנת פיתוח מיומנויות וכישורים בעולם העבודה החדש','אחמד','פעילות',2340,2480.4,2480.4,'עבר להנה"ח','08-04-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-18-2024','51',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','הנחיה והדרכה','תכנית הכשרה לסטודמטים  מכללת עזראלי ','אחמד','פעילות',14215.5,15068.43,15068.43,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17910524','05-28-2024','40068',791,'עברית ושפת אם',12,'אולפנים בתוך שעות הלימודים','סופטאפ  ','לייווי פידגוגי תכנית הוראה עברית מאי 24','הראל','שכר',23400,24804,24804,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17870524','05-28-2024','50020',787,'תכנית ישראלית',5,'בית אלחכמה ','מודול פתרונות  ','סדנת מוזיקה ','מלחם ','פעילות',8800,9328,9328,'עבר להנה"ח','07-07-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17870524','05-28-2024','50021',787,'תכנית ישראלית',5,'בית אלחכמה ','מודול פתרונות  ','מכשירי כתיבה כרוזים עיצוב הזמנות ','מלחם ','פעילות',2000,2120,2120,'עבר להנה"ח','07-07-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17870524','05-28-2024','IN244000339',787,'תכנית ישראלית',3,'ליווי פדגוגי','ספריית הענן  ','ליווי בתי ספר 04/24','אמיר','פעילות',87300,92538,92538,'עבר להנה"ח','07-07-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17870524','05-28-2024','10071',787,'תכנית ישראלית',3,'ליווי פדגוגי','לב האקדמיה  ','ליווי חינוכי','נעמה','פעילות',5100,5406,5406,'עבר להנה"ח','07-07-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','10-27-2024','3055',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר עזריאלי','הנחיה והדרכה','תכנית הכשרה לסטודמטים  מכללת עזראלי ','אחמד','פעילות',14215,15067.9,15067.9,'בקשת תשלום','10-27-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ה','10-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17870524','05-29-2024','IN244000443',787,'תכנית ישראלית',3,'ליווי פדגוגי','ספריית הענן  ','לייווי בתי ספר 05/24','אמיר','פעילות',152100,161226,161226,'עבר להנה"ח','07-07-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17910524','05-30-2024','11027',791,'עברית ושפת אם',12,'אולפנים בתוך שעות הלימודים','שחר מחשבים  ','הכנה לבגרות בעברית דבורה מרץ מאי 24 ','אורלי','פעילות',38638.59,40956.9054,40956.9054,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17870524','05-30-2024','11028',787,'תכנית ישראלית',3,'ליווי פדגוגי','שחר מחשבים  ','שעות תגבור חורף מאי 24','אורלי','פעילות',12870,13642.2,13642.2,'עבר להנה"ח','07-07-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17920524','05-30-2024','48',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידים מאי 24 ','עאידה','פעילות',702,744.12,744.12,'עבר להנה"ח','07-16-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17920524','05-30-2024','49',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידים מאי 24 ','עאידה','פעילות',661.5,701.19,701.19,'עבר להנה"ח','07-16-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17920524','05-30-2024','50',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידים מאי 24 ','עאידה','פעילות',737,781.22,781.22,'עבר להנה"ח','07-16-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17940324','04-04-2024','227',794,'בלתי פורמלי',33,'בתי ספר מנגנים','פעלויות מטריפות','פעילות בית ספר מנגן +מנות אוכל ','עבד','פעילות',2600,2756,2756,'עבר להנה"ח','05-28-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-0005','1512','05-30-2024','1512',787,'תכנית ישראלית',18,'קלמגה',' שירותי שיווק              ','הפעלת  תכנית  לבתי ספר מ.ירושלים תכנית פלסטינית','רנאן','פעילות',90360,90360,90360,'עבר להנה"ח','07-21-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-0005','1532','05-30-2024','1532',787,'תכנית ישראלית',18,'קלמגה',' שירותי שיווק              ','חומרים להפעלת תונית בבית ספר תכנית פלסטינית ','רנאן','פעילות',68040,68040,68040,'עבר להנה"ח','07-21-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17910524','05-30-2024','23524',791,'עברית ושפת אם',17,'מרכז שפות ','הרמוניה עסקית  ','כיבוד לתלמידים ','אריג','פעילות',491,520.46,520.46,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','1790524','06-04-2024','92',790,'ניהול ובקרה',1,'ניהול ובקרה','פיקס פתרונות  ','חניה','לביא','שכר',1800,1908,1908,'עבר להנה"ח','07-14-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17930424','05-02-2024','08/117697',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','סופר','ממתקים לתלמידים לרגל רמדאן ','רנא','פעילות',69.5,73.67,73.67,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930624','07-01-2024','08/134114',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','סופר','מים ','רנא','פעילות',64.5,68.37,68.37,'עבר להנה"ח','08-04-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','7910424','06-04-2024','7910424',791,'עברית ושפת אם',17,'מרכז שפות ','לביא','שכר מנהלת מרכז שפות אפריל 24','לביא','שכר',11240.7,11915.142,11915.142,'עבר להנה"ח','07-16-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17940524','06-04-2024','43',794,'בלתי פורמלי',38,'קונסרבטוריון','המרכז המוזיקלי  ','ניהול הקונסרבטוריון לחודש מאי 2024','ברק','פעילות',159841,169431.46,169431.46,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17950524','06-04-2024','950930/7',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','מנעולנות קידום נוער מאי 24','עבד','פעילות',16000,16960,16960,'עבר להנה"ח','09-25-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17950524','06-04-2024','729871/6',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','חשמל ביתי עיסוואיה תיכון בנים מאי 24','עבד','פעילות',8000,8480,8480,'עבר להנה"ח','09-25-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17950524','06-04-2024','641407/5',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','חשמל ביתי תיכון מחנה שועפאט מאי 24','עבד','פעילות',32000,33920,33920,'עבר להנה"ח','09-25-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-11-2024','IN244000091',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','אקדמיה','תכנית לכיתות יב אלבשאאיר בצלאל','רנא','פעילות',33740,35764.4,35764.4,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-08-2024','40024',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','פעלויות מטריפות','ערכות אמנות לתלמידי אלבשאיר בצלאל ','רנא','פעילות',4998,5297.88,5297.88,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930624','06-06-2024','IN240000619',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','בוטיק הים  ','סיור בספרייה הלאומית מאי 24','רנא','פעילות',1288,1365.28,1365.28,'עבר להנה"ח','08-04-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','7920524','06-06-2024','7920524',792,'טיפול בפרט ומניעת נשירה',29,'טיפול בפרט','לביא','שכר עובדים מאי 2024','לביא','שכר',867991.509433962,920071,920071,'עבר להנה"ח','10-27-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','7910524','06-06-2024','7910524',791,'עברית ושפת אם',17,'מרכז שפות ','לביא','שכר מנהלת מרכז שפות מאי 24','לביא','שכר',11240.5660377358,11915,11915,'עבר להנה"ח','07-07-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','7870524','06-06-2024','7870524',787,'תכנית ישראלית',5,'קלף מנצח תכנית לשיפור הישגים ','לביא','שכר עובדים מאי 24','לביא','שכר',15896.2264150943,16850,16850,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','790524','06-06-2024','790524',790,'ניהול ובקרה',1,'ניהול ובקרה','לביא','שכר עובדים מאי 24','לביא','שכר',117905.283018868,124979.6,17263.8,'עבר להנה"ח','07-21-2024','משכורת של עבד בלבד','משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','7930524','06-06-2024','7930524',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר ','לביא','שכר עובדים מאי 24','לביא','שכר',115093.839622642,121999.47,83419,'עבר להנה"ח','06-06-2024','אלבשאיר תלמידים בלבד','משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','7940524','06-06-2024','7950424',794,'בלתי פורמלי',33,'בתי ספר מנגנים','לביא','שכר עובדים מאי 24','לביא','שכר',70587.7358490566,74823,74823,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','7950524','06-06-2024','79504024',795,'חינוך מדעי טכנולוגי',21,'חדר כושר אלקמה','לביא','שכר עובדים מאי 24','לביא','שכר',16386.7924528302,17370,0,'עבר להנה"ח','07-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17950524','06-10-2024','10025',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','הכוכב המזרחי  ','קורסים טכנולוגי מאי 24','עבד','פעילות',478383,507085.98,507085.98,'עבר להנה"ח','09-25-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-0005','1579','06-10-2024','1579',787,'תכנית ישראלית',5,'קלמגה',' שירותי שיווק              ','תכנית  בתי ספר מ.ירושלים תכנית ישראלית ','רנאן','פעילות',158400,158400,158400,'עבר להנה"ח','07-07-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17870624','06-10-2024','1581',787,'תכנית ישראלית',5,'וורד',' שירותי שיווק              ','תכנית  עבור בתי ספר מ.ירושלים תכנית ישראלית','רנאן ','פעילות',25600,27136,27136,'עבר להנה"ח','07-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('עירייה','36-24-0011','90030065','06-10-2024','90030065',NULL,'חינוך מדעי טכנולוגי',19,'מעבדות בלהמונטה ',' אוניברסיטת ירושלים       ','ביצוע מעבדות תשפ"ד','נועה','פעילות',0,354900,354900,'עבר להנה"ח','07-21-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17950524','06-10-2024','26',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','יוזמה עסקית  ','קורסים טכנולוגים מאי 24','עבד','פעילות',68235.26,72329.3756,72329.3756,'עבר להנה"ח','09-25-2024',NULL,'משרד החינוך','כן ','06-13-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('עירייה','36-24-0004','2024-02','06-13-2024','2024-02',NULL,'תכנית ישראלית',5,'חסאנה','ספיידר קמפוס  ','תכנית  אפריל עד מאי 24','רנאן','פעילות',183501,183501,183501,'עבר להנה"ח','07-21-2024',NULL,'משרד החינוך','כן ','06-13-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910324','03-21-2024','90024',791,'עברית ושפת אם',17,'מרכז שפות ','עברית','שעות לימוד קבוצות פברואר 2024','רוברט','פעילות',26853.8,28465.028,28465.028,'עבר להנה"ח','05-02-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910624','06-16-2024','233000038',791,'עברית ושפת אם',16,'כל טכנולוגי ללימוד עברית ','טוקספייס בע"מ  ','שעות פרונטליות של ליווי צוותי ההוראה - אפריל מאי יוני','הראל','פעילות',38142,40430.52,40430.52,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930624','06-23-2024','942',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים',' בדר הפקות                 ','כיבוד קל ושתיה לתלמידים ','רנא','פעילות',3680,3900.8,3900.8,'עבר להנה"ח','08-04-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-23-325','57900923','07-04-2024','3169',790,'ניהול ובקרה',1,'ניהול ובקרה','אדן פרויקטים  ','שכר ספטמבר 2023','לביא','שכר',41535,44027.1,0,'עבר להנה"ח','06-24-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','09-2023')
 INSERT [Invoices] VALUES('לביא','36-23-366','57901023','07-04-2024','3171',790,'ניהול ובקרה',1,'ניהול ובקרה','אדן פרויקטים  ','שכר אוקטובר 2023','לביא','שכר',41535,44027.1,0,'עבר להנה"ח','06-25-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','10-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','57901123','07-04-2024','3175',790,'ניהול ובקרה',1,'ניהול ובקרה','אדן פרויקטים  ','שכר נובמבר 2023','לביא','שכר',41535,44027.1,0,'עבר להנה"ח','06-26-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא',NULL,'57900424','05-09-2024','3188',790,'ניהול ובקרה',1,'ניהול ובקרה','אדן פרויקטים  ','שכר אפריל 2024','לביא','שכר',41535,44027.1,0,'בקשת תשלום','06-27-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'57900524','06-05-2024','2000',790,'ניהול ובקרה',1,'ניהול ובקרה','אדן פרויקטים  ','שכר מאי  2024','לביא','שכר',41535,44027.1,0,'בקשת תשלום','06-28-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17940624','06-23-2024','1503',794,'בלתי פורמלי',33,'בתי ספר מנגנים',' סברי תיירות               ','פעילות עבור צוות בי"ס מנגן ','עבד','פעילות',10000,10600,10600,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910324','03-31-2024','90025',791,'עברית ושפת אם',17,'מרכז שפות ','עברית','שעות לימוד קבוצות מרץ  2024','רוברט','פעילות',45227.5,47941.15,47941.15,'עבר להנה"ח','05-02-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17920624','06-27-2024','10073',792,'טיפול בפרט ומניעת נשירה',29,'טיפול בפרט','לב האקדמיה  ','ליווי חינוכי','נעמה','פעילות',1800,1908,1908,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','4450424','06-30-2024','4450424',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','שכר עובדים מרכז מצטיינים אפריל 24','מנון','שכר',51111,54177.66,54177.66,'עבר להנה"ח','07-10-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','4450524','06-30-2024','4450524',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','שכר עובדים מרכז מצטיינים מאי 24','מנון','שכר',69078,73222.68,73222.68,'עבר להנה"ח','07-10-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','14450524','06-30-2024','14450524',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','ספקים  מרכז מצטיינים מאי 24','מנון','פעילות',28317.5,30016.55,30016.55,'עבר להנה"ח','07-10-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','19610424','06-30-2024','17910424',961,'בלתי פורמלי',34,'העצמה','לביא','ספקים העצמה 04/24','בתיה','פעילות',111450,117022.5,117022.5,'עבר להנה"ח','07-07-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','19610524','06-30-2024','19610524',961,'בלתי פורמלי',34,'העצמה','לביא','ספקים הצעמה 05/24','בתיה','פעילות',555479,583252.95,583252.95,'עבר להנה"ח','07-07-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','9610424','06-30-2024','9610424',961,'בלתי פורמלי',34,'העצמה','לביא','שכר עובדים העצמה 04/24','בתיה','שכר',22404.6,23524.83,23524.83,'עבר להנה"ח','07-07-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','9610524','06-30-2024','9610524',961,'בלתי פורמלי',34,'העצמה ','לביא','שכר עובדים העצמה 05/24','בתיה','שכר',43982,46181.1,46181.1,'עבר להנה"ח','07-07-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','9660424','06-30-2024','9660424',966,'בלתי פורמלי',34,'יוניברסיטי','לביא','שכר עובדים יונברסיטי אפריל 2024 ','בתיה','שכר',3803.6,3993.78,3993.78,'עבר להנה"ח','07-07-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','9660524','06-30-2024','9660524',966,'בלתי פורמלי',34,'יוניברסיטי','לביא','שכר עובדים יונברסיטי מאי 2024 ','בתיה','שכר',7664.7,8047.935,8047.935,'עבר להנה"ח','07-07-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','19660524','06-30-2024','19660524',966,'בלתי פורמלי',34,'יוניברסיטי','לביא','ספקים העצמה יונברסטי 05/24','בתיה','פעילות',17760,18648,18648,'עבר להנה"ח','07-07-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','9630424','06-30-2024','9630424',963,'בלתי פורמלי',37,'מדצי"ם','לביא','שכר מדצ"ים 04/24','בתיה','שכר',221179,232237.95,232237.95,'עבר להנה"ח','07-07-2024',NULL,'משרד החינוך','כן','06-16-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','9630524','06-30-2024','9630524',963,'בלתי פורמלי',37,'מדצי"ם','לביא','שכר מדצ"ים 05/24','בתיה','שכר',247716.9,260102.745,260102.745,'עבר להנה"ח','09-08-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','19630524','06-30-2024','19630524',963,'בלתי פורמלי',37,'מדצי"ם','לביא','ספקים מדצים 05/24','בתיה','פעילות',59990,62989.5,62989.5,'עבר להנה"ח','07-07-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17910424','04-30-2024','90026',791,'עברית ושפת אם',17,'מרכז שפות ','עברית','שעות לימוד קבוצתיות אפריל 24','רוברט','פעילות',22613.76,23970.5856,23970.5856,'עבר להנה"ח','06-10-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17950624','07-01-2024','729871/7',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','חשמל ביתי -עיסוויה בנים  יוני 24','עבד','פעילות',28000,29680,29680,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17950624','07-01-2024','641407/6',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','חשמל ביתי - תיכון מותנבי מחנה שועפאט  יוני 24','עבד','פעילות',24000,25440,25440,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17950624','07-01-2024','950930/8',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','קרן עוגן  ','מנעולנות -קידום נוער יוני 24','עבד','פעילות',24000,25440,25440,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17910524','05-30-2024','90027',791,'עברית ושפת אם',17,'מרכז שפות','עברית','שעות לימוד קבוצתיות מאי 24','רוברט','פעילות',39574.08,41948.5248,41948.5248,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930624','07-01-2024','2874',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','חלום עתידי בע"מ  ','כיבוד לתלמידים ','רנא','פעילות',319,338.14,338.14,'עבר להנה"ח','08-04-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930624','07-01-2024','8170867',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים',' ספריית הידע               ','ציוד ','רנא','פעילות',123,130.38,130.38,'עבר להנה"ח','08-04-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910724','08-05-2024','90028',791,'עברית ושפת אם',17,'מרכז שפות ','עברית','שעות ליווי יוני ','אריג','פעילות',14133.6,14981.616,14981.616,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','09-29-2024','12493',791,'עברית ושפת אם',14,'תכנית מדברים ','ביגל','כיבוד להכשרת מורים ','איתמר ','פעילות',626,663.56,663.56,'בקשת תשלום','09-29-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','09-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17950324','04-01-2024','10023',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','כוכבים','דיווח פעילות קורסים טכנולוגיים חודש 03/24','עבד','פעילות',98566.67,104480.6702,104480.6702,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910624','07-01-2024','724',791,'עברית ושפת אם',17,'מרכז שפות ','עלים בע"מ  ','בקבוקי מים מתנות ','אריג','פעילות',7000,7420,7420,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910624','07-01-2024','734',791,'עברית ושפת אם',17,'מרכז שפות ','עלים בע"מ  ','בקבוקי מים מתנות ','אריג','פעילות',7000,7420,7420,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17950424','05-06-2024','10024',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','כוכבים','דיווח פעילות קורסים טכנולוגיים חודש 04/24','עבד','פעילות',229513,243283.78,243283.78,'עבר להנה"ח','07-11-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17950624','07-01-2024','10027',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','כוכבים','דיווח פעילות קורסים טכנולוגים יוני 24 ','עבד','פעילות',246889.5,261702.87,261702.87,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-30-2024','183',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','הסעות','הסעות תלמידים','אחמד','פעילות',4500,4770,4770,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-30-2024','184',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','הסעות','הסעות תלמידים','אחמד','פעילות',4000,4240,4240,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910624','07-02-2024','2024-510486',791,'עברית ושפת אם',17,'מרכז שפות ','הרמוניה עסקית  ','מיץ  לתלמידים ','אריג','פעילות',497.5,527.35,527.35,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910624','07-03-2024','2024-539707',791,'עברית ושפת אם',17,'מרכז שפות ','הרמוניה עסקית  ','ציוד למרכז שפות ','אריג','פעילות',422.8,448.168,448.168,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910624','07-04-2024','2024-539741',791,'עברית ושפת אם',17,'מרכז שפות ','הרמוניה עסקית  ','כיבוד ליום סיום ','אריג','פעילות',1100,1166,1166,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910624','07-05-2024','2024-543612',791,'עברית ושפת אם',17,'מרכז שפות ','הרמוניה עסקית  ','כיבוד ליום סיום ','אריג','פעילות',1100,1166,1166,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910624','07-06-2024','2024-543709',791,'עברית ושפת אם',17,'מרכז שפות ','הרמוניה עסקית  ','שירות משלוח לכל החודש ','אריג','פעילות',500,530,530,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17920624','07-04-2024','1715',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','פעלויות מטריפות','הצגה התחנה האחרונה 7/24','עאידה','פעילות',5500,5830,5830,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17920824','08-27-2024','22',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','צלם ','צילום ההצגה הסופית ','אריג','פעילות',11200,11872,11872,'בקשת תשלום','08-27-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17910224','02-25-2024','24/00006909',791,'עברית ושפת אם',17,'מרכז שפות ','חשמל','קומקום למרכז שפות ','אריג','פעילות',120,127.2,127.2,'עבר להנה"ח','04-04-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17930424','04-02-2024','40292',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר סטודנטים תואר ראשון','ספריית השדרה  ','ליווי תעסוקתי ומקצועי דצמבר- פברואר 24','אסתר','פעילות',19305,20463.3,0,'עבר להנה"ח','06-30-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','02-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17870624','07-01-2024','IN244000519',787,'תכנית ישראלית',3,'ליווי פדגוגי','ספריית הענן  ','ליווי בתי ספר 06/24','אמיר','פעילות',140700,149142,149142,'עבר להנה"ח','07-30-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910624','07-01-2024','60132',791,'עברית ושפת אם',12,'אולפנים בתוך שעות הלימודים','סופטאפ  ','לייווי פידגוגי תכנית הוראה עברית יוני 24','הראל','שכר',23400,24804,24804,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910624','07-01-2024','5580',791,'עברית ושפת אם',17,'מרכז שפות ','כוכב המטריקס  ','סל מכשרי כתיבה ואמנות ','אריג','פעילות',7000,7420,7420,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('עירייה','36-24-0060','90030385','07-01-2024','90030385',NULL,'עברית ושפת אם',5,'היא נקרא ',' אוניברסיטת ירושלים       ','קריאה תשפ"ד','רנאן','פעילות',33600,33600,33600,'עבר להנה"ח','08-04-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'7920624','07-02-2024','7920624',792,'טיפול בפרט ומניעת נשירה',29,'טיפול בפרט','לביא','שכר עובדים יוני 24','לביא','שכר',1262362,1338103.72,1338103.72,'בקשת תשלום','07-02-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','7910624','07-02-2024','7910624',791,'עברית ושפת אם',17,'מרכז שפות ','לביא','שכר עובדת יוני 24','לביא','שכר',16984.7,18003.782,18003.782,'עבר להנה"ח','09-12-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','7930624','07-02-2024','7930624',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר ','לביא','שכר עובדים יוני 24','לביא','שכר',170107,180313.42,127697,'עבר להנה"ח','09-25-2024','אלבשאיר תלמידים בלבד','משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','7870624','07-02-2024','7870624',787,'תכנית ישראלית',5,'קלף מנצח תכנית לשיפור הישגים ','לביא','שכר עובדים יוני 24','לביא','שכר',17989,19068.34,19068.34,'עבר להנה"ח','09-12-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','7940624','07-02-2024','7940624',794,'בלתי פורמלי',33,'בתי ספר מנגנים','לביא','שכר עובדים יוני 24','לביא','שכר',94368.49,100030.5994,100030.5994,'עבר להנה"ח','09-12-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','7950624','07-02-2024','7950624',795,'חינוך מדעי טכנולוגי',21,'חדר כושר אלקמה','לביא','שכר עובדים יוני 24 ','לביא','שכר',15586.36,16521.5416,0,'עבר להנה"ח','09-12-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','7900624','07-02-2024','790624',790,'ניהול ובקרה',1,'ניהול ובקרה','לביא','שכר עובדים יוני 24 ','לביא','שכר',172304.8,182643.088,23186.07,'עבר להנה"ח','10-27-2024','שכר עבד בלבד','משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17900624','07-04-2024','30000',790,'ניהול ובקרה',1,'ניהול ובקרה','פיקס פתרונות  ','חניה','לביא','שכר',900,954,0,'עבר להנה"ח','08-18-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17930424','05-05-2024','40304',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר סטודנטים תואר ראשון','ספריית השדרה  ','ליווי תעסוקתי ומקצועי מרץ  24 ','אסתר','פעילות',6435,6821.1,0,'עבר להנה"ח','06-30-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'57900624','07-04-2024','2001',790,'ניהול ובקרה',1,'ניהול ובקרה','אדן פרויקטים  ','שכר יוני 24','לביא','שכר',41535,44027.1,0,'בקשת תשלום','07-04-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17920624','07-04-2024','57',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידים ','עאידה','פעילות',936,992.16,992.16,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17920624','07-04-2024','56',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידים ','עאידה','פעילות',643,681.58,681.58,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17920624','07-04-2024','55',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידים ','עאידה','פעילות',532,563.92,563.92,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17920624','07-04-2024','53',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידים ','עאידה','פעילות',468,496.08,496.08,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17920624','07-04-2024','54',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידים ','עאידה','פעילות',234,248.04,248.04,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17920624','07-04-2024','51',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידים ','עאידה','פעילות',702,744.12,744.12,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17920624','07-04-2024','52',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידים ','עאידה','פעילות',748,792.88,792.88,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17930524','05-09-2024','40307',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תואר ראשון ','ספריית השדרה  ','ליווי תעסוקתי אפריל','לביא','פעילות',6435,6821.1,6821.1,'עבר להנה"ח','05-22-2024','לא','משרד החינוך',NULL,NULL,2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17930424','05-12-2024','40307',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר סטודנטים תואר ראשון','ספריית השדרה  ','ליווי תעסוקתי ומקצועי אפריל 24 ','אסתר','פעילות',6435,6821.1,0,'עבר להנה"ח','06-30-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17920624','07-04-2024','2072024',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','מערב מחשבים  ','השכרת אודיטוריום כולל הפעלה אורקולית 6/24','עאידה','פעילות',8000,8480,8480,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','14450624','07-07-2024','14450624',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','ספקים מרכז מצטיינים יוני 24','מנון','פעילות',7260,7695.6,7695.6,'עבר להנה"ח','07-30-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','4450624','07-07-2024','4450624',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','שכר עובדים יוני 24','מנון','שכר',67765.6,71831.536,71831.536,'עבר להנה"ח','07-10-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17900624','07-08-2024','500221',790,'ניהול ובקרה',1,'ניהול ובקרה','פיקס פתרונות  ','חניה','רבקה','פעילות',6750,7155,0,'עבר להנה"ח','08-18-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17940624','07-08-2024','44',794,'בלתי פורמלי',38,'קונסרבטוריון','המרכז המוזיקלי  ','ניהול הקונסרבטוריון לחודש יוני 2024','ברק','פעילות',105888,112241.28,112241.28,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930624','06-06-2024','40314',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר סטודנטים תואר ראשון','ספריית השדרה  ','סדנת לינקדאין מקיפה לקבוצת אלבשאיר 5/24','אסתר','פעילות',1200,1272,0,'עבר להנה"ח','08-04-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930624','06-06-2024','40313',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר סטודנטים תואר ראשון','ספריית השדרה  ','ליווי תעסוקתי והנחיית קבוצות מאי 24','אסתר','פעילות',6435,6821.1,0,'עבר להנה"ח','08-04-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-18-2024','40322',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר סטודנטים תואר ראשון','ספריית השדרה  ','ליווי תעסוקתי ומקצועי יוני ','אסתר','פעילות',6435,6821.1,0,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17950824','07-15-2024','10028',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','הכוכב המזרחי  ','דיווח פעילות קורסים טכולוגים יולי 24','עבד','פעילות',10983,11641.98,11641.98,'בקשת תשלום','07-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17870724','07-16-2024','16724',787,'תכנית ישראלית',5,'דיבייט תשפד ','ספריית האופק  ','תכנית  תשפד ','רנאן ','פעילות',32160,34089.6,34089.6,'עבר להנה"ח','10-14-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17940724','07-17-2024','45',794,'בלתי פורמלי',38,'קונסרבטוריון','המרכז המוזיקלי  ','ניהול הקונסרבטוריון לחודש יולי 2024','ברק','פעילות',23173,24563.38,24563.38,'עבר להנה"ח','09-12-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','08-04-2024','40330',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר סטודנטים תואר ראשון','ספריית השדרה  ','ליווי תעסוקתי ומקצועי יולי ','אסתר','פעילות',6435,6821.1,0,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17920824','07-18-2024','58',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','פיצה לתלידים יולי 24','עאידה','פעילות',550,583,583,'בקשת תשלום','07-18-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17930924','09-22-2024','40340',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר סטודנטים תואר ראשון','ספריית השדרה  ','ליווי תעסוקתי ומקצועי אוגוסט  ','אסתר','פעילות',6435,6821.1,0,'בקשת תשלום','09-22-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17930424','05-02-2024','10517970',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים',' פתרונות תחבורה           ','חד פעמי לאירוע סיום בצלאל ','רנא','פעילות',90.4,95.824,95.824,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17930224','02-29-2024','40002',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','עידן הרשת  ','שערי עברית תכנית אלבשאאיר ינואר-פברואר 2024','שי','פעילות',46800,49608,49608,'עבר להנה"ח','04-14-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930524','05-28-2024','40004',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','עידן הרשת  ','שיעורי עברית מרץ-מאי ','שי','פעילות',53235,56429.1,56429.1,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930624','06-13-2024','40005',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','עידן הרשת  ','שיעורי עברית יוני','שי','פעילות',4095,4340.7,4340.7,'עבר להנה"ח','08-04-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-21-2024','40007',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','עידן הרשת  ','קורס קיץ תכנית אלבשאיר ','שי','פעילות',53703,56925.18,56925.18,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17870724','07-21-2024','50031',787,'תכנית ישראלית',5,'בית אלחכמה ','מודול פתרונות  ','רכישת כלל החומרים המתכלים למגמה ','מלחם','פעילות',16000,16960,16960,'עבר להנה"ח','10-14-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17870724','07-21-2024','50032',787,'תכנית ישראלית',5,'בית אלחכמה ','מודול פתרונות  ','ארוחה קלה, סדנת אמון,תעודת סיום, עיצוב הזמנה ','מלחם','פעילות',10013,10613.78,10613.78,'עבר להנה"ח','10-14-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17930324','03-26-2024','450',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','סופר מדיה בע"מ  ','פעילות גיבוש לרכזי אלבשאאיר ','רנא','פעילות',1800,1908,1908,'עבר להנה"ח','05-12-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17930424','04-03-2024','467',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','סופר מדיה בע"מ  ','פעילות O.D.T  ברחבי האוני העברית 4/24','רנא','פעילות',7605,8061.3,8061.3,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-101','2197','07-21-2024','2197',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','תבונה טכנולוגית  ','הסעות תלמידים תכנית אלבשאיר רבעון ראשון תשפד ','רנא','פעילות',0,191814,191814,'עבר להנה"ח','08-04-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17950824','07-21-2024','210724',795,'חינוך מדעי טכנולוגי',20,'מעבדות ניידות ','ספריית האופק  ','מעבדות ניידות ממרץ עד יוני 2024 ','מנון','פעילות',58650,62169,62169,'בקשת תשלום','07-21-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'7940624','07-22-2024','7940624',794,'בלתי פורמלי',33,'בתי ספר מנגנים','לביא','שכר עובדים יוני 24','לביא','שכר',94368.49,100030.5994,100030.5994,'עבר להנה"ח','10-09-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','7850624','07-22-2024','7850624',787,'תכנית ישראלית',6,'חיזוק לימוד ומעטפת במעבר לתכנית ישראלית','לביא','שכר עובדים יוני 24 ','לביא','שכר',72192.09,76523.6154,76523.6154,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17870724','07-23-2024','PI24000008',787,'תכנית ישראלית',11,'חותם מנהלים','חותם זהב  ','חותם מניגות ירושלמית דרישה  2/2','אירה','פעילות',150000,159000,159000,'עבר להנה"ח','10-14-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17870724','07-23-2024','PI24000006',787,'תכנית ישראלית',11,'חותם מורים','חותם זהב  ','חותם מורים תשלום 2/2','אירה','פעילות',150000,159000,159000,'עבר להנה"ח','10-14-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17870724','07-23-2024','PI24000007',787,'תכנית ישראלית',3,'ליווי פדגוגי','חותם זהב  ','ליווי בתי ספר תשפד ','אירה','פעילות',200000,212000,212000,'עבר להנה"ח','10-14-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'9610624','07-23-2024','960624',961,'בלתי פורמלי',34,'העצמה ','לביא','שכר עובדים העצמה 06/24','בתיה','שכר',42303.8,44418.99,44418.99,'בקשת תשלום','10-07-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'9660624','07-23-2024','9660624',966,'בלתי פורמלי',34,'יוניברסיטי','לביא','שכר עובדים יונברסיטי יוני 24','בתיה','שכר',12539,13165.95,13165.95,'בקשת תשלום','10-07-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','19610624','07-23-2024','19610624',961,'בלתי פורמלי',34,'העצמה','לביא','ספקים הצעמה 06/24','בתיה','פעילות',495945.7,520742.985,520742.985,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','19660624','07-23-2024','19660624',966,'בלתי פורמלי',34,'יוניברסיטי','לביא','ספקים העצמה יונברסטי 06/24','בתיה','פעילות',8447.5,8869.875,8869.875,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('עירייה','36-24-0071','90030855','07-23-2024','90030855',NULL,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים',' אוניברסיטת ירושלים       ','תכנית אלבשאיר  מסמטר א תשפד','רנא','פעילות',0,233827,233827,'עבר להנה"ח','11-12-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-100','2196','07-24-2024','2196',795,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים ','תבונה טכנולוגית  ','הסעות בי"ס אסמאא בנת אבי בקר ','עבד','פעילות',0,13263,13263,'בחתימות','08-04-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17910824','09-02-2024','359318',791,'עברית ושפת אם',17,'מרכז שפות ','חנות ספרים','ספרים למרכז שפות ','אריג','פעילות',446,472.76,472.76,'בקשת תשלום','09-02-2024',NULL,'משרד החינוך','כן ','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17910924','10-01-2024','20012',791,'עברית ושפת אם',14,'תכנית מדברים ','יורם','יועץ ומנהל תפעולי  09/24','איתמר ','שכר',14040,14882.4,14882.4,'בקשת תשלום','10-01-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','09-2024')
 INSERT [Invoices] VALUES('עירייה','36-24-0011','90030910','07-28-2024','90030910',NULL,'חינוך מדעי טכנולוגי',19,'מעבדות בלהמונטה ',' אוניברסיטת ירושלים       ','השתלמויות מורים תכנית החומש','נועה','פעילות',0,46200,46200,'עבר להנה"ח','08-20-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-29-2024','2295',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','תבונה טכנולוגית  ','נסיעות לתלמידים תכנית אלבשאיר ','רנא','פעילות',7289,7726.34,7726.34,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-29-2024','2296',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','תבונה טכנולוגית  ','נסיעות לתלמידים תכנית אלבשאיר ','רנא','פעילות',1041,1103.46,1103.46,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-29-2024','983',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים',' בדר הפקות                 ','הדפסות ומתנות מערכות קול ליום סיום ','רנא','פעילות',20000,21200,21200,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-29-2024','152',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','כוכב המטריקס  ','מדבקות , טושים , הדפסות ','רנא','פעילות',150,159,159,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-29-2024','153',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','כוכב המטריקס  ','הדפסות ','רנא','פעילות',110,116.6,116.6,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-29-2024','494',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','סופר מדיה בע"מ  ','סדנת גיבוש משתתפים ','רנא','פעילות',17433,18478.98,18478.98,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-29-2024','146',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','כוכב המטריקס  ','מדבקות , טושים , הדפסות ','רנא','פעילות',148,156.88,156.88,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-29-2024','8172703',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים',' ספריית הידע               ','ציוד  משרדי ','רנא','פעילות',90,95.4,95.4,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-29-2024','8171482',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים',' ספריית הידע               ','ציוד  משרדי ','רנא','פעילות',61,64.66,64.66,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-29-2024','8172590',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים',' ספריית הידע               ','ציוד  משרדי ','רנא','פעילות',132,139.92,139.92,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','11-03-2024','20015',791,'עברית ושפת אם',14,'תכנית מדברים ','יורם','יועץ ומנהל תפעולי  10/24','איתמר ','שכר',8775,9301.5,9301.5,'בקשת תשלום','11-03-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','10-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17950824','07-18-2024','IN2408481',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','עיתון','פרסום על מכרזי קורסים טכנולוגים בעיתונאות ','עבד','פעילות',1966,2083.96,2083.96,'בקשת תשלום','07-18-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-102','17930424','05-02-2024','1339',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','אוכל','סעודת איפטר לתלמידים 04/2024','רנא','פעילות',6400,6784,6784,'עבר להנה"ח','06-30-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910624','07-07-2024','39/3',791,'עברית ושפת אם',17,'מרכז שפות ','משה','משקפיים מתנה תלמידי מרכז שפות ','אריג','פעילות',144,152.64,152.64,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910624','07-08-2024','40/1',791,'עברית ושפת אם',17,'מרכז שפות ','משה','משקפיים מתנה תלמידי מרכז שפות ','אריג','פעילות',144,152.64,152.64,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910624','07-09-2024','40/2',791,'עברית ושפת אם',17,'מרכז שפות ','משה','משקפיים מתנה תלמידי מרכז שפות ','אריג','פעילות',144,152.64,152.64,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-30-2024','250724',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','מודול פתרונות  ','כיבוד לתלמידים ','אחמד','פעילות',50.85,53.901,53.901,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-30-2024','150823',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','מודול פתרונות  ','כיבוד לתלמידים ','אחמד','פעילות',132,139.92,139.92,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-30-2024','90524',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','מודול פתרונות  ','כיבוד לתלמידים ','אחמד','פעילות',56.7,60.102,60.102,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-30-2024','150823',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','מודול פתרונות  ','כיבוד לתלמידים ','אחמד','פעילות',146.9,155.714,155.714,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910624','07-10-2024','40/4',791,'עברית ושפת אם',17,'מרכז שפות ','משה','משקפיים מתנה תלמידי מרכז שפות ','אריג','פעילות',144,152.64,152.64,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17950124','02-06-2024','1316',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים','יוזמה עסקית  ','קורסים טכנולוגים ינואר 2024','עבד','פעילות',81269,86145.14,86145.14,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-30-2024','230524',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','מודול פתרונות  ','כיבוד לתלמידים ','אחמד','פעילות',59,62.54,62.54,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17930124','01-21-2024','11002',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','אלפא לוגיסטיקה  ','אוכל לתלמידים ','רנא','פעילות',3640,3858.4,3858.4,'עבר להנה"ח','03-10-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','12-2023')
 INSERT [Invoices] VALUES('לביא','36-23-408','17930324','03-21-2024','210324',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','אלפא לוגיסטיקה  ','סעודת איפטר 3/24','אחמד','פעילות',15000,15900,15900,'עבר להנה"ח','05-12-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17930824','09-02-2024','180824',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר עזריאלי','אלפא לוגיסטיקה  ','כיבוד לתלמידים ','אחמד','פעילות',1390,1473.4,1473.4,'בקשת תשלום','09-02-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17950524','05-28-2024','249633',795,'חינוך מדעי טכנולוגי',26,'קורסים טכנולוגיים',' המלון בהר                 ','אולם ליריד הטכנולוגי ','עבד','פעילות',25974,27532.44,27532.44,'עבר להנה"ח','09-25-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','04-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17920824','08-29-2024','527',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','הצגות','פעילות קיץ לתלמידי תיאטרון ','אריג','פעילות',44000,46640,46640,'בקשת תשלום','08-29-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-31-2024','240524',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר סטודנטים תואר ראשון','איילון טכנולוגיות  ','ליווי והדרכה מאי יוני ','ולאא','פעילות',5000,5300,0,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-31-2024','300624',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר סטודנטים תואר ראשון','איילון טכנולוגיות  ','ליווי והדרכה יוני יולי','ולאא','פעילות',5000,5300,0,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','07-31-2024','500230',790,'ניהול ובקרה',1,'ניהול ובקרה','זרעי השמש בע"מ  ','חניה','רבקה','פעילות',4500,4770,4770,'בקשת תשלום','07-31-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910724','08-01-2024','60135',791,'עברית ושפת אם',12,'אולפנים בתוך שעות הלימודים','סופטאפ  ','לייווי פידגוגי תכנית הוראה עברית יולי 24','לביא','שכר',23400,24804,24804,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','7950724','08-01-2024','7950724',795,'חינוך מדעי טכנולוגי',21,'חדר כושר אלקמה','לביא','שכר עובדים יולי 24','לביא','שכר',5487,5816.22,0,'עבר להנה"ח','10-14-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','7940724','08-01-2024','7940724',794,'בלתי פורמלי',33,'בתי ספר מנגנים','לביא','שכר עובדים יולי 24','לביא','שכר',69955,74152.3,74152.3,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','7910724','08-01-2024','7910724',791,'עברית ושפת אם',17,'מרכז שפות ','לביא','שכר עובדים יולי 24','לביא','שכר',16102.69,17068.8514,17068.8514,'עבר להנה"ח','10-27-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','7900724','08-01-2024','7900724',790,'ניהול ובקרה',1,'ניהול ובקרה','לביא','שכר עובדים יולי 24','לביא','שכר',121618,128915.08,17143.9,'עבר להנה"ח','10-27-2024','שכר עבד בלבד','משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','7870724','08-01-2024','7870724',787,'תכנית ישראלית',5,'קלף מנצח תכנית לשיפור הישגים ','לביא','שכר עובדים יולי 24','לביא','שכר',19517.5,20688.55,20688.55,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'7920724','08-01-2024','7920724',792,'טיפול בפרט ומניעת נשירה',29,'טיפול בפרט','לביא','שכר עובדים יולי 24','לביא','שכר',848905.8,899840.148,899840.148,'בקשת תשלום','08-01-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','7930724','08-01-2024','7930724',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר ','לביא','שכר עובדים יולי 24','לביא','שכר',109173.8,115724.228,92617,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17870724','08-01-2024','IN244000589',787,'תכנית ישראלית',3,'ליווי פדגוגי','ספריית הענן  ','ליווי בתי ספר 7/24 ','אמיר','פעילות',70800,75048,75048,'עבר להנה"ח','10-14-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','4450724','08-04-2024','4450724',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','שכר עובדים מרכז מצטיינים ולי 24','מנון','שכר',14706,15588.36,15588.36,'עבר להנה"ח','08-20-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17910924','10-10-2024','1209229',791,'עברית ושפת אם',14,'תכנית מדברים ','מכולת','כיבוד ','איתמר ','פעילות',115,121.9,121.9,'בקשת תשלום','10-14-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','09-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','09-18-2024','412',787,'תכנית ישראלית',5,'הלן דורון ','עתיד חכם בע"מ  ','תכנית  8 מפגשים ','רנאן','פעילות',28800,30528,30528,'בקשת תשלום','09-18-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('עירייה','36-23-405','007/2024','08-05-2024','2024/007',NULL,'תכנית ישראלית',5,'די בונו ','הדפוס הירוק  ','חומרי לימוד עד יולי 24','רנאן','פעילות',0,16960,16960,'עבר להנה"ח','11-12-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910724','08-05-2024','3801',791,'עברית ושפת אם',17,'מרכז שפות ','הרמוניה עסקית  ','כיבוד ','אריג','פעילות',368,390.08,390.08,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','08-15-2024','30002',790,'ניהול ובקרה',1,'ניהול ובקרה','פיקס פתרונות  ','חניייה  08/24','לביא','פעילות',900,954,0,'בקשת תשלום','08-15-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','09-18-2024','411',787,'תכנית ישראלית',5,'עסאפיר','עתיד חכם בע"מ  ','תכנית  8 מפגשים תכנית ישראלית','רנאן','פעילות',33600,35616,35616,'בקשת תשלום','09-18-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא','36-23-408','17930124','01-23-2024','3672',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים','חנות הדובדבן  ','חלב ועוגות לצוות ','רנא','פעילות',100,106,106,'עבר להנה"ח','05-02-2024',NULL,'משרד החינוך','כן','03-30-2024',2024,'תשפ"ד','01-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17870824','08-22-2024','11170',787,'תכנית ישראלית',3,'ליווי פדגוגי','שחר מחשבים  ','שעות תגבור חורף אוגוסט 24','אורלי','פעילות',1544,1636.64,1636.64,'בקשת תשלום','08-22-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2023')
 INSERT [Invoices] VALUES('לביא',NULL,'17870824','08-22-2024','10075',787,'תכנית ישראלית',3,'ליווי פדגוגי','לב האקדמיה  ','ליווי חינוכי','נעמה','פעילות',3000,3180,3180,'בקשת תשלום','08-22-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2023')
 INSERT [Invoices] VALUES('לביא','36-24-227','19630624','08-26-2024','19630624',963,'בלתי פורמלי',37,'מדצי"ם','לביא','ספקים מדצים 06/24','בתיה','פעילות',65670,68953.5,68953.5,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','19630724','08-26-2024','19630724',963,'בלתי פורמלי',37,'מדצי"ם','לביא','ספקים מדצים 07/24','בתיה','פעילות',748021.98,785423.079,785423.079,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'9630624','08-26-2024','9630624',963,'בלתי פורמלי',37,'מדצי"ם','לביא','שכר מדצים יוני 2024','בתיה','שכר',259578.06,272556.963,272556.963,'בקשת תשלום','08-26-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'9630724','08-26-2024','9630724',963,'בלתי פורמלי',37,'מדצי"ם','לביא','שכר מדצים יולי 2024','בתיה','שכר',214302.33,225017.4465,225017.4465,'בקשת תשלום','08-26-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'9610724','08-26-2024','9610724',961,'בלתי פורמלי',34,'העצמה','לביא','שכר עובדים העצמה 07/24','בתיה','שכר',42374.81,44493.5505,44493.5505,'בקשת תשלום','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','9660724','08-26-2024','9660724',966,'בלתי פורמלי',34,'יוניברסיטי','לביא','שכר עובדים יונברסיטי יולי 24','בתיה','שכר',1800.4,1890.42,1890.42,'עבר להנה"ח','10-27-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17920824','08-26-2024','2877',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','חלום עתידי בע"מ  ','כיבוד לתלמידים יולי 24','עאידה','פעילות',1760,1865.6,1865.6,'בקשת תשלום','08-26-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17920824','08-26-2024','60',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','עוגות +בורקס לתלמדייפ ','עאידה','פעילות',678,718.68,718.68,'בקשת תשלום','08-26-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17920824','08-26-2024','61',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','משלוש פיצה ועודות ','עאידה','פעילות',491,520.46,520.46,'בקשת תשלום','08-26-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17920824','08-26-2024','62',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','בית הלחם  ','כיבוד לתלמידים ','עאידה','פעילות',748,792.88,792.88,'בקשת תשלום','08-26-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17930824','09-08-2024','3691',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים ','חנות הדובדבן  ','כיבוד ','רנא','פעילות',83,87.98,87.98,'בקשת תשלום','09-08-2024',NULL,'משרד החינוך','לא',NULL,2024,'תשפ"ד','11-2023')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-30-2024','190624',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','קפיטריה חללית','כיבוד לתלמידים ','אחמד','פעילות',66,69.96,69.96,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','14450724','08-27-2024','14450724',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','ספקים יולי מרכז מצטיינים 24','מרגלית','פעילות',20821,22070.26,22070.26,'עבר להנה"ח','10-14-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17950824','08-27-2024','270824',795,'חינוך מדעי טכנולוגי',22,'חשיבה חישובית','ספריית האופק  ','תכנית חווארזמי ינואר עד יולי 24','מנון','פעילות',518072,549156.32,549156.32,'בקשת תשלום','08-27-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-30-2024','240724',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','קפיטריה חללית','כיבוד לתלמידים ','אחמד','פעילות',43.22,45.8132,45.8132,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17920824','08-27-2024','1002',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון',' בדר הפקות                 ','כיבוד, צילום, תחרות בישול,הדפסות','אריג','פעילות',48200,51092,51092,'בקשת תשלום','08-27-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-30-2024','290524',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','קפיטריה חללית','כיבוד לתלמידים ','אחמד','פעילות',50,53,53,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('עירייה','36-24-0004','2024-01','03-24-2024','2024-01',NULL,'תכנית ישראלית',5,'חסאנה','ספיידר קמפוס  ','מפגשי תכנית  12/23 עד 3/24','רנאן ','פעילות',142899,142899,142899,'עבר להנה"ח','04-07-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','03-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17910824','08-29-2024','233000054',791,'עברית ושפת אם',16,'כל טכנולוגי ללימוד עברית ','טוקספייס בע"מ  ','רשיונות שימוש חודשי ל21 כיתות - יולי אוגוסט ','הראל','פעילות',9828,10417.68,10417.68,'בקשת תשלום','08-29-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('עירייה','36-24-0071','90031360','08-29-2024','90031360',NULL,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים ',' אוניברסיטת ירושלים       ','תכנית אלבשאיר סמסטר ב תשפד ','אסנת','פעילות',0,194394,194394,'עבר להנה"ח','11-12-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17870824','08-29-2024','IN244000625',787,'תכנית ישראלית',3,'ליווי פדגוגי','ספריית הענן  ','ליווי בתי ספר 08/24','אמיר','פעילות',34800,36888,36888,'בקשת תשלום','08-29-2024',NULL,'משרד החינוך','כן ','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17940824','08-29-2024','562',794,'בלתי פורמלי',33,'בתי ספר מנגנים','דרכים מתקדמות  ','גיבוש צוות כולל הפעלה לצוות ','עבד','פעילות',7000,7420,7420,'בקשת תשלום','08-29-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930624','06-04-2024','40204',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','מעביר סדנאות','סדנת חזון וזהות אישיות ','אחמד','פעילות',3071.25,3255.525,3255.525,'עבר להנה"ח','08-04-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-0011','1943','09-01-2024','1943',795,'חינוך מדעי טכנולוגי',19,'מעבדות בלהמונטה ','תבונה טכנולוגית  ','סיוע במימון הסעות בלהמונטה ביס אל רואד ','נורא','פעילות',0,10000,10000,'עבר להנה"ח','09-01-2024',NULL,'משרד החינוך','כן','06-13-2024',2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17930624','06-04-2024','40084',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','מעביר סדנאות','סדנת סנגור עצמי','אחמד','פעילות',1500,1590,1590,'עבר להנה"ח','08-04-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','05-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17920824','09-03-2024','1000',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון',' בדר הפקות                 ','תחרות בטבע , הדפסת חולצות ','אריג','פעילות',26000,27560,27560,'בקשת תשלום','09-02-2024',NULL,'משרד החינוך','כן ','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17920824','07-18-2024','40025',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','מעביר סדנאות','סדנת מוזיקה ','עאידה','פעילות',3000,3180,3180,'בקשת תשלום','07-18-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910624','07-01-2024','385',791,'עברית ושפת אם',17,'מרכז שפות ','עבודה משרדית','הדפסת תעודות סיום  תלמידי מרכז שפות ','אריג','פעילות',150,159,159,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17930824','09-03-2024','46',794,'בלתי פורמלי',38,'קונסרבטוריון','המרכז המוזיקלי  ','ניהול הקונסרבטוריון לחודש אוגוסט  2024','ברק','פעילות',28809,30537.54,30537.54,'בקשת תשלום','09-03-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910624','07-01-2024','386',791,'עברית ושפת אם',17,'מרכז שפות ','עבודה משרדית','הדפסת תעודות סיום  תלמידי מרכז שפות ','אריג','פעילות',150,159,159,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17910824','09-03-2024','3921',791,'עברית ושפת אם',17,'מרכז שפות ','הרמוניה עסקית  ','כיבוד ','אריג','פעילות',1192.5,1264.05,1264.05,'בקשת תשלום','09-03-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'7930824','09-03-2024','7930824',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר ','לביא','שכר עובדים אוגוסט 24','לביא','שכר',87678.78,92939.5068,73617.92,'בקשת תשלום','09-03-2024','אלבשאיר תלמידים בלבד','משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'7950824','09-03-2024','7950824',795,'חינוך מדעי טכנולוגי',21,'חדר כושר אלקמה','לביא','שכר עובדים אוגוסט 24','לביא','שכר',10361,10982.66,10982.66,'בקשת תשלום','10-01-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'7940824','09-03-2024','7940824',794,'בלתי פורמלי',33,'בתי ספר מנגנים','לביא','שכר עובדים אוגוסט 24','לביא','שכר',76482,81070.92,81070.92,'בקשת תשלום','09-03-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'7900824','09-03-2024','7900824',790,'ניהול ובקרה',1,'ניהול ובקרה','לביא','שכר עובדים אוגוסט 24','לביא','שכר',131628.58,139526.2948,18767,'בקשת תשלום','09-03-2024','שכר עבד בלבד','משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'7920824','09-03-2024','7920824',792,'טיפול בפרט ומניעת נשירה',29,'טיפול בפרט','לביא','שכר עובדים אוגוסט 24','לביא','שכר',753903.45,799137.657,799137.657,'בקשת תשלום','09-03-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','7850724','09-19-2024','7850724',787,'תכנית ישראלית',6,'חיזוק לימוד ומעטפת במעבר לתכנית ישראלית','לביא','שכר עובדים יולי ','לביא','שכר',23736.6,25160.796,25160.796,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'7850824','09-03-2024','7850824',787,'תכנית ישראלית',6,'חיזוק לימוד ומעטפת במעבר לתכנית ישראלית','לביא','שכר עובדים אוגוסט 24','לביא','שכר',7710,8172.6,8172.6,'בקשת תשלום','10-01-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'7870824','09-03-2024','7870824',787,'תכנית ישראלית',5,'קלף מנצח תכנית לשיפור הישגים ','לביא','שכר עובדים אוגוסט 24','לביא','שכר',14589.5,15464.87,15464.87,'בקשת תשלום','10-01-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'7910824','09-03-2024','7910824',791,'עברית ושפת אם',17,'מרכז שפות ','לביא','שכר עובדת אוגוסט 24','לביא','שכר',11210,11882.6,11766.5,'בקשת תשלום','10-01-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','4450824','09-03-2024','4450824',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','שכר אוגוסט 2024','לביא','שכר',9635,10213.1,10213.1,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','14450824','09-03-2024','14550824',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','לביא','ספקים אוגוסט 24','לביא','פעילות',183634.69,194652.7714,194652.7714,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'9630824','09-03-2024','9630824',963,'בלתי פורמלי',37,'מדצי"ם','לביא','שכר מדצים אוגוסט  2024','בתיה','שכר',241498.86,253573.803,253573.803,'בקשת תשלום','09-03-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'9610824','09-03-2024','9610824',961,'בלתי פורמלי',34,'העצמה','לביא','שכר עובדים העצמה 08/24','בתיה','שכר',38595.01,40524.7605,40524.7605,'בקשת תשלום','09-03-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'9660824','09-03-2024','9660824',966,'בלתי פורמלי',34,'יוניברסיטי','לביא','שכר עובדים יונברסיטי אוגוסט  24','בתיה','שכר',34.11,35.8155,35.8155,'בקשת תשלום','09-03-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','19610824','09-03-2024','19610824',961,'בלתי פורמלי',34,'העצמה','לביא','ספקים העצמה 08/24','בתיה','פעילות',154734,162470.7,162470.7,'עבר להנה"ח','10-07-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17950824','09-04-2024','290824',795,'חינוך מדעי טכנולוגי',24,'מרכז מצטיינים','ספריית האופק  ','וודעת היגוי מרכז מצטיינים תשפד','מנון ','שכר',45000,47700,47700,'בקשת תשלום','09-04-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17930824','09-08-2024','8120570',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים ',' ספריית הידע               ','הדפסות ','רנא','פעילות',80,84.8,84.8,'בקשת תשלום','09-08-2024',NULL,'משרד החינוך','לא',NULL,2024,'תשפ"ד','06-2023')
 INSERT [Invoices] VALUES('לביא',NULL,'17930824','09-08-2024','8132662',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים ',' ספריית הידע               ','הדפסות ','רנא','פעילות',25,26.5,26.5,'בקשת תשלום','09-08-2024',NULL,'משרד החינוך','לא',NULL,2024,'תשפ"ד','10-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910624','07-01-2024','387',791,'עברית ושפת אם',17,'מרכז שפות ','עבודה משרדית','הדפסת תעודות סיום  תלמידי מרכז שפות ','אריג','פעילות',150,159,159,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17910624','07-01-2024','388',791,'עברית ושפת אם',17,'מרכז שפות ','עבודה משרדית','הדפסת תעודות סיום  תלמידי מרכז שפות ','אריג','פעילות',150,159,159,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'57900724','09-09-2024','2002',790,'ניהול ובקרה',1,'ניהול ובקרה','אדן פרויקטים  ','שכר יולי 24','לביא','שכר',41535,44027.1,0,'בקשת תשלום','09-09-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'57900824','09-09-2024','2004',790,'ניהול ובקרה',1,'ניהול ובקרה','אדן פרויקטים  ','שכר אוגוסט 24','לביא','שכר',41535,44027.1,0,'בקשת תשלום','09-09-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17950924','09-10-2024','100924',795,'חינוך מדעי טכנולוגי',22,'חשיבה חישובית','ספריית האופק  ','חווארזמי ביצוע אוגוסט 24','מנון','פעילות',25992.97,27552.5482,27552.5482,'בקשת תשלום','09-10-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','09-16-2024','1638',787,'תכנית ישראלית',5,'לומדים ונהנים ',' שירותי שיווק              ','תכנית לומדים ונהנים תשפד ','רנאן','פעילות',27000,28620,28620,'בקשת תשלום','09-16-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'IN244000007','07-28-2024','IN244000007',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','מכללה','תפעול תכנית אלבשאיר ','אחמד','פעילות',20000,21200,21200,'עבר להנה"ח','07-28-2024','הכנסות אחרות','לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17920824','07-18-2024','832',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','עמותה של עמותה','ביקור ופעילות במוזיאון אום אלפחם תלמידי תאטרון 7/24','עאידה','פעילות',800,848,848,'בקשת תשלום','07-18-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-160','17870624','06-27-2024','9098',787,'תכנית ישראלית',3,'ליווי פדגוגי','מלווים','ליווי תהליך כתיבת פרוגרמה פדגוגית עבור בית ספר תיירות.','שירלי','פעילות',17550,18603,18603,'עבר להנה"ח','07-30-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17910924','09-22-2024','40070',791,'עברית ושפת אם',12,'אולפנים בתוך שעות הלימודים','סופטאפ  ','לייווי פידגוגי תכנית הוראה עברית ספטמבר  24','הראל','שכר',23400,24804,24804,'בקשת תשלום','09-22-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ד','09-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17870824','08-15-2024','9101',787,'תכנית ישראלית',3,'ליווי פדגוגי','מלווים','ליווי תהליך כתיבת פרוגרמה פדגוגית עבור בית ספר תיירות.','שירלי','פעילות',23400,24804,24804,'בקשת תשלום','08-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','10-01-2024','30005',790,'ניהול ובקרה',1,'ניהול ובקרה','פיקס פתרונות  ','חניה','לביא','פעילות',900,954,954,'בקשת תשלום','10-01-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','09-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','10-01-2024','30006',790,'ניהול ובקרה',1,'ניהול ובקרה','פיקס פתרונות  ','חניה','לביא','פעילות',900,954,954,'בקשת תשלום','10-01-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ה','10-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-30-2024','20624',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','גירפות גבוהות','כיבוד לתלמידים ','אחמד','פעילות',42.1,44.626,44.626,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17910924','10-01-2024','4026',791,'עברית ושפת אם',17,'מרכז שפות ','הרמוניה עסקית  ','כיבוד ','אריג','פעילות',2107.5,2233.95,2233.95,'בקשת תשלום','10-01-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ד','09-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'7950924','10-01-2024','7950924',795,'חינוך מדעי טכנולוגי',21,'חדר כושר אלקמה','לביא','שכר עובד 09/24','לביא','שכר',10864.3867924528,11516.25,11516.25,'בקשת תשלום','10-01-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','09-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17910924','10-01-2024','7910924',791,'עברית ושפת אם',17,'מרכז שפות','לביא','שכר עובדת 09/24','לביא','שכר',12100.6603773585,12826.7,12826.7,'בקשת תשלום','10-01-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','09-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'7920924','10-01-2024','7920924',792,'טיפול בפרט ומניעת נשירה',29,'טיפול בפרט','לביא','שכר עובדים 09/24','לביא','שכר',779501.886792453,826272,826272,'בקשת תשלום','10-01-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','09-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','10-01-2024','7900924',790,'ניהול ובקרה',1,'ניהול ובקרה','לביא','שכר עובדים 09/24','לביא','שכר',128101.41509434,135787.5,135787.5,'בקשת תשלום','10-01-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ה','09-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'7930924','10-01-2024','7930924',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר','לביא','שכר עובדים 09/24','לביא','שכר',99295.2830188679,105253,105253,'בקשת תשלום','10-01-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','09-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','10-01-2024','7850924',787,'תכנית ישראלית',6,'חיזוק לימוד ומעטפת במעבר לתכנית ישראלית','לביא','שכר עובדים 09//24','לביא','שכר',53177.0754716981,56367.7,56367.7,'בקשת תשלום','10-01-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','09-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','10-01-2024','7940924',794,'בלתי פורמלי',33,'בתי ספר מנגנים','לביא','שכר עובדים 09/24','לביא','שכר',90566.9811320755,96001,96001,'בקשת תשלום','10-01-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','09-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','10-01-2024','7870924',787,'תכנית ישראלית',5,'קלף מנצח ','לביא','שכר עובדים 09/24','לביא','שכר',11991.5094339623,12711,12711,'בקשת תשלום','10-01-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','09-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'19610924','10-07-2024','19610924',961,'בלתי פורמלי',34,'העצמה','לביא','ספקים ספטמבר 24','לביא','פעילות',7000,7350,7350,'בקשת תשלום','10-07-2024',NULL,'משרד החינוך','לא',NULL,2024,'תשפ"ד','09-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17910924','10-07-2024','1637',791,'עברית ושפת אם',14,'המודל המקיף בעברית',' שירותי שיווק              ','שי למנהלים כנס המודל המקיף בעברית ','עביר','פעילות',2808,2976.48,2976.48,'בקשת תשלום','10-07-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','09-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17930924','10-08-2024','בקשת תשלום ',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר תלמידים ',' בדר הפקות                 ','כיבוד אוריינטציה','רנא','פעילות',2600,2756,2756,'בקשת תשלום','10-08-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','09-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','10-08-2024','2005',790,'ניהול ובקרה',1,'ניהול ובקרה','אדן פרויקטים  ','שכר ספטמבר 2024','לביא','שכר',41535,44027.1,0,'בקשת תשלום','10-08-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ה','09-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','10-10-2024','500232',790,'ניהול ובקרה',1,'ניהול ובקרה','זרעי השמש בע"מ  ','חניה','לביא','פעילות',2250,2385,2385,'בקשת תשלום','10-10-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ה','09-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-30-2024','180724',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','גירפות גבוהות','כיבוד לתלמידים ','אחמד','פעילות',57,60.42,60.42,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-30-2024','60624',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','גירפות גבוהות','כיבוד לתלמידים ','אחמד','פעילות',63.4,67.204,67.204,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','10-27-2024','40071',791,'עברית ושפת אם',14,'תכנית מדברים ','סופטאפ  ','ליווי פדגוגי אוקטובר 2024','הראל','שכר',23400,24804,24804,'בקשת תשלום','10-27-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','10-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17930724','07-30-2024','230524',793,'חינוך מדעי טכנולוגי',25,'אלבשאאיר סטודנטים  עזראילי','גירפות גבוהות','כיבוד לתלמידים ','אחמד','פעילות',148.7,157.622,157.622,'עבר להנה"ח','10-07-2024',NULL,'לא',NULL,NULL,2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'17920824','08-27-2024','20',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','רייזרים','סדנאות תעשיית כסאות, קורסים עיצוב ','אריג','פעילות',48100,50986,50986,'בקשת תשלום','08-27-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','08-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','11-03-2024','8179227',793,'ניהול ובקרה',25,'אלבשאיר תלמידים ',' ספריית הידע               ','ציוד ','רנא','פעילות',34,36.04,36.04,'בקשת תשלום','11-03-2024',NULL,'משרד החינוך','לא',NULL,2024,'תשפ"ד','09-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','11-03-2024','47',794,'בלתי פורמלי',38,'קונסרבטוריון','המרכז המוזיקלי  ','ניהול הקונסרבטריון  ספטמבר 2024','ברק','פעילות',104573,110847.38,110847.38,'בקשת תשלום','11-03-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','10-2024')
 INSERT [Invoices] VALUES('לביא','36-24-227','17920624','07-04-2024','40086',792,'טיפול בפרט ומניעת נשירה',30,'תיאטרון','תיאטרון היופי','הצגת דה גאבו 6/24','עאידה','פעילות',9000,9540,9540,'עבר להנה"ח','09-15-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','06-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','11-04-2024','7851024',787,'תכנית ישראלית',6,'חיזוק לימוד ומעטפת במעבר לתכנית ישראלית','לביא','שכר עובדים 10/24','לביא','שכר',15796.56,16744.3536,16744.3536,'בקשת תשלום','11-04-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','10-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','11-04-2024','7871024',787,'תכנית ישראלית',5,'קלף מנצח תכנית לשיפור הישגים ','לביא','שכר עובדים 10/24','לביא','שכר',15280.27,16197.0862,16197.0862,'בקשת תשלום','11-04-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','10-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','11-04-2024','7901024',790,'ניהול ובקרה',1,'ניהול ובקרה','לביא','שכר עובדים 10/24','לביא','שכר',127781.64,135448.5384,18355.31,'בקשת תשלום','11-04-2024','שכר עבד בלבד','משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','10-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','11-04-2024','7911024',791,'עברית ושפת אם',14,'תכנית מדברים ','לביא','שכר עובדים 10/24','לביא','שכר',27918.5,29593.61,29593.61,'בקשת תשלום','11-04-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','10-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','11-04-2024','7921024',792,'טיפול בפרט ומניעת נשירה',29,'טיפול בפרט','לביא','שכר עובדים 10/24','לביא','שכר',891976.44,945495.0264,945495.0264,'בקשת תשלום','11-04-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','10-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','11-04-2024','7931024',793,'חינוך מדעי טכנולוגי',25,'אלבשאיר ','לביא','שכר עובדים 10/24','לביא','שכר',112419.02,119164.1612,107557,'בקשת תשלום','11-04-2024','אלבשאיר תלמידים +מחוננים ','משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','10-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','11-04-2024','7941024',794,'בלתי פורמלי',33,'בתי ספר מנגנים','לביא','שכר עובדים 10/24','לביא','שכר',79586.67,84361.8702,84361.8702,'בקשת תשלום','11-04-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','10-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','11-04-2024','7951024',795,'חינוך מדעי טכנולוגי',21,'חדר כושר אלקמה','לביא','שכר עובדים 10/24','לביא','שכר',10067.94,10672.0164,10672.0164,'בקשת תשלום','11-04-2024','לדיווח ? ','משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','10-2024')
 INSERT [Invoices] VALUES('עירייה','36-24-0001','10724','07-09-2024','10724',NULL,'תכנית ישראלית',5,'סמארטי','חינוכיות','תכנית  מספטמבר עד יוני 24','רנאן','פעילות',89440,89440,89440,'עבר להנה"ח','07-30-2024',NULL,'משרד החינוך','כן','08-30-2024',2024,'תשפ"ד','07-2024')
 INSERT [Invoices] VALUES('לביא',NULL,'בקשת תשלום ','11-13-2024','10079',787,'תכנית ישראלית',3,'ליווי פדגוגי','לב האקדמיה  ','ליווי חינוכי','נעמה','שכר',2400,2544,2544,'בקשת תשלום','11-13-2024',NULL,'משרד החינוך','כן','12-01-2024',2024,'תשפ"ה','10-2024')
GO




