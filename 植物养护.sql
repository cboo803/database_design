USE [master]
GO
/****** Object:  Database [植物养护数据库]    Script Date: 2023/12/26 19:32:03 ******/
CREATE DATABASE [植物养护数据库]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'植物养护数据库', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\植物养护数据库.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'植物养护数据库_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\植物养护数据库_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [植物养护数据库] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [植物养护数据库].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [植物养护数据库] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [植物养护数据库] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [植物养护数据库] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [植物养护数据库] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [植物养护数据库] SET ARITHABORT OFF 
GO
ALTER DATABASE [植物养护数据库] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [植物养护数据库] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [植物养护数据库] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [植物养护数据库] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [植物养护数据库] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [植物养护数据库] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [植物养护数据库] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [植物养护数据库] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [植物养护数据库] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [植物养护数据库] SET  DISABLE_BROKER 
GO
ALTER DATABASE [植物养护数据库] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [植物养护数据库] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [植物养护数据库] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [植物养护数据库] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [植物养护数据库] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [植物养护数据库] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [植物养护数据库] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [植物养护数据库] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [植物养护数据库] SET  MULTI_USER 
GO
ALTER DATABASE [植物养护数据库] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [植物养护数据库] SET DB_CHAINING OFF 
GO
ALTER DATABASE [植物养护数据库] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [植物养护数据库] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [植物养护数据库] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [植物养护数据库] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [植物养护数据库] SET QUERY_STORE = ON
GO
ALTER DATABASE [植物养护数据库] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [植物养护数据库]
GO
/****** Object:  User [shenna]    Script Date: 2023/12/26 19:32:03 ******/
CREATE USER [shenna] FOR LOGIN [shenna] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[用户表]    Script Date: 2023/12/26 19:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[用户表](
	[用户名称] [nvarchar](50) NULL,
	[手机号] [nvarchar](50) NULL,
	[邮箱] [nvarchar](50) NULL,
	[家庭住址] [nvarchar](50) NULL,
	[登陆密码] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[植物养护表]    Script Date: 2023/12/26 19:32:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[植物养护表](
	[任务编号] [nchar](10) NULL,
	[任务名称] [varchar](50) NULL,
	[执行时间] [varchar](50) NULL,
	[执行地点] [varchar](50) NULL,
	[执行人员] [varchar](50) NULL,
	[任务描述] [varchar](50) NULL,
	[养护对象] [varchar](50) NULL
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [植物养护数据库] SET  READ_WRITE 
GO
