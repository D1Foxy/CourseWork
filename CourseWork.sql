USE [master]
GO
/****** Object:  Database [CourseWork]    Script Date: 14.03.2023 16:46:34 ******/
CREATE DATABASE [CourseWork]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CourseWork', FILENAME = N'C:\Users\foxdi\CourseWork.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CourseWork_log', FILENAME = N'C:\Users\foxdi\CourseWork_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CourseWork] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CourseWork].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CourseWork] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CourseWork] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CourseWork] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CourseWork] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CourseWork] SET ARITHABORT OFF 
GO
ALTER DATABASE [CourseWork] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [CourseWork] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CourseWork] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CourseWork] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CourseWork] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CourseWork] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CourseWork] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CourseWork] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CourseWork] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CourseWork] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CourseWork] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CourseWork] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CourseWork] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CourseWork] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CourseWork] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CourseWork] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CourseWork] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CourseWork] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CourseWork] SET  MULTI_USER 
GO
ALTER DATABASE [CourseWork] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CourseWork] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CourseWork] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CourseWork] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CourseWork] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CourseWork] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [CourseWork] SET QUERY_STORE = OFF
GO
USE [CourseWork]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 14.03.2023 16:46:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 14.03.2023 16:46:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Surname] [nvarchar](100) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Patronymic] [nvarchar](100) NOT NULL,
	[DoB] [nvarchar](100) NOT NULL,
	[Gruppa] [nvarchar](50) NOT NULL,
	[GPA] [decimal](19, 1) NOT NULL,
	[Photo] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 14.03.2023 16:46:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Surname] [nvarchar](100) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Patronymic] [nvarchar](100) NOT NULL,
	[Login] [nvarchar](max) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[Role] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id], [Name]) VALUES (1, N'Директор')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (2, N'Классный руководитель')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[Students] ON 

INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (3, N'Адоньев', N'Александр', N'Романович', N'2003-08-29', N'ИП-195', CAST(5.0 AS Decimal(19, 1)), N'_01ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (4, N'Алиева', N'Минара', N'Исаевна', N'2003-11-19', N'ИП-195', CAST(2.7 AS Decimal(19, 1)), N'_02ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (5, N'Бондаренко', N'Дмитрий', N'Игоревич', N'2003-08-01', N'ИП-195', CAST(4.9 AS Decimal(19, 1)), N'_03ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (6, N'Бруснев', N'Дмитрий', N'Максимович', N'2003-04-20', N'ИП-195', CAST(3.6 AS Decimal(19, 1)), N'_04ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (7, N'Горянский', N'Иван', N'Романович', N'2002-09-03', N'ИП-195', CAST(3.8 AS Decimal(19, 1)), N'_06ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (8, N'Джафаров', N'Александр', N'Александрович', N'2003-03-23', N'ИП-195', CAST(3.5 AS Decimal(19, 1)), N'_07ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (9, N'Ковалевский', N'Дмитрий', N'Дмитриевич', N'2002-12-31', N'ИП-195', CAST(3.2 AS Decimal(19, 1)), N'_29ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (10, N'Лабушкин', N'Иван', N'Евгеньевич', N'2003-03-09', N'ИП-195', CAST(4.0 AS Decimal(19, 1)), N'_08ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (11, N'Магомедов', N'Магомед', N'Шамильевич', N'2004-10-02', N'ИП-195', CAST(2.5 AS Decimal(19, 1)), N'_09ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (12, N'Мацукатов', N'Христафор', N'Юрьевич', N'2003-07-03', N'ИП-195', CAST(3.0 AS Decimal(19, 1)), N'_12ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (13, N'Момотов', N'Евгений', N'Алексеевич', N'2002-04-12', N'ИП-195', CAST(3.6 AS Decimal(19, 1)), N'_28ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (14, N'Москаленко', N'Станислав', N'Сергеевич', N'2003-02-13', N'ИП-195', CAST(4.2 AS Decimal(19, 1)), N'_11ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (15, N'Падалка ', N'Максим', N'Геннадьевич', N'2003-09-10', N'ИП-195', CAST(2.0 AS Decimal(19, 1)), N'_13ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (16, N'Пискун', N'Геннадий', N'Александрович', N'2003-07-29', N'ИП-195', CAST(3.5 AS Decimal(19, 1)), N'_14ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (17, N'Пшеничный', N'Денис', N'Викторович', N'2003-03-21', N'ИП-195', CAST(4.0 AS Decimal(19, 1)), N'_16ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (18, N'Романов', N'Иван', N'Андреевич', N'2002-09-03', N'ИП-195', CAST(4.0 AS Decimal(19, 1)), N'_17ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (19, N'Рыщенко', N'Виталий', N'Юрьевич', N'2002-02-14', N'ИП-195', CAST(2.5 AS Decimal(19, 1)), N'_18ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (20, N'Рябцев', N'Кирилл', N'Леонидович', N'2002-12-18', N'ИП-195', CAST(4.0 AS Decimal(19, 1)), N'_19ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (21, N'Стрельников', N'Дмитрий', N'Дмитриевич', N'2003-04-23', N'ИП-195', CAST(2.5 AS Decimal(19, 1)), N'_20ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (22, N'Фоменко', N'Максим', N'Сергеевич', N'2003-07-07', N'ИП-195', CAST(3.5 AS Decimal(19, 1)), N'_21ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (23, N'Фролов', N'Максим', N'Александрович', N'2003-08-29', N'ИП-195', CAST(4.0 AS Decimal(19, 1)), N'_26ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (24, N'Харченко', N'Дмитрий', N'Артурович', N'2003-04-02', N'ИП-195', CAST(2.1 AS Decimal(19, 1)), N'_22ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (25, N'Шкир', N'Артем', N'Деносович', N'2003-08-04', N'ИП-195', CAST(4.5 AS Decimal(19, 1)), N'_23ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (26, N'Шураев', N'Федор', N'Михайлович', N'2003-02-19', N'ИП-195', CAST(3.5 AS Decimal(19, 1)), N'_24ip195.jpg')
INSERT [dbo].[Students] ([Id], [Surname], [Name], [Patronymic], [DoB], [Gruppa], [GPA], [Photo]) VALUES (27, N'Щеглов', N'Артем', N'Александрович', N'2004-01-13', N'ИП-195', CAST(2.0 AS Decimal(19, 1)), N'_25ip195.jpg')
SET IDENTITY_INSERT [dbo].[Students] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id], [Surname], [Name], [Patronymic], [Login], [Password], [Role]) VALUES (1, N'Черторевский', N'Герман ', N'Ефимович', N'1', N'1', 1)
INSERT [dbo].[User] ([Id], [Surname], [Name], [Patronymic], [Login], [Password], [Role]) VALUES (2, N'Родионов', N'Владимир', N'Иванович', N'm4ic8j5qgstw@gmail.com', N'2L6KZG', 2)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD FOREIGN KEY([Role])
REFERENCES [dbo].[Role] ([Id])
GO
USE [master]
GO
ALTER DATABASE [CourseWork] SET  READ_WRITE 
GO
