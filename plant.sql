USE [plant]
GO
/****** Object:  Table [dbo].[养护任务]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[养护任务](
	[养护任务编号] [int] NOT NULL,
	[任务名称] [nvarchar](100) NULL,
	[执行时间] [datetime] NULL,
	[执行地点] [nvarchar](100) NULL,
	[执行人员] [nvarchar](100) NULL,
	[任务描述] [nvarchar](255) NULL,
	[养护对象] [nvarchar](100) NULL,
	[创建人员] [nvarchar](100) NULL,
	[创建时间] [datetime] NULL,
	[更新时间] [datetime] NULL,
	[病虫害编号] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[养护任务编号] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[园林植物基本信息管理业务]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[园林植物基本信息管理业务](
	[编号] [nvarchar](50) NOT NULL,
	[种名] [nvarchar](50) NOT NULL,
	[科名] [nvarchar](50) NOT NULL,
	[别名] [nvarchar](50) NOT NULL,
	[形态特征] [nvarchar](50) NULL,
	[栽培技术要点] [nvarchar](50) NULL,
	[应用价值] [nvarchar](50) NULL,
 CONSTRAINT [PK_园林植物基本信息管理业务_1] PRIMARY KEY CLUSTERED 
(
	[编号] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[园林植物分类管理]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[园林植物分类管理](
	[编号] [nvarchar](50) NOT NULL,
	[科名] [nvarchar](50) NOT NULL,
	[属名] [nvarchar](50) NOT NULL,
	[种名] [nvarchar](50) NOT NULL,
	[别名] [nvarchar](50) NULL,
	[生长环境] [nvarchar](50) NULL,
 CONSTRAINT [PK_园林植物分类管理] PRIMARY KEY CLUSTERED 
(
	[编号] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[上级主管]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[上级主管]
AS
SELECT dbo.园林植物基本信息管理业务.*, dbo.园林植物分类管理.属名, dbo.园林植物分类管理.生长环境, dbo.养护任务.任务名称, dbo.养护任务.创建人员, dbo.养护任务.创建时间, 
            dbo.养护任务.更新时间, dbo.养护任务.病虫害编号, dbo.养护任务.任务描述, dbo.养护任务.执行人员
FROM    dbo.园林植物基本信息管理业务 INNER JOIN
            dbo.园林植物分类管理 ON dbo.园林植物基本信息管理业务.编号 = dbo.园林植物分类管理.编号 INNER JOIN
            dbo.养护任务 ON dbo.园林植物分类管理.编号 = dbo.养护任务.养护任务编号
GO
/****** Object:  View [dbo].[不同科名的植物]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[不同科名的植物]
AS
SELECT 编号, 科名, 种名
FROM    dbo.园林植物基本信息管理业务
GO
/****** Object:  Table [dbo].[配图信息]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[配图信息](
	[编号] [nvarchar](50) NOT NULL,
	[种名] [nvarchar](50) NOT NULL,
	[配图1] [nvarchar](200) NULL,
	[配图1文件名] [nvarchar](50) NULL,
	[配图1拍摄地点] [nvarchar](50) NULL,
	[配图1描述] [nvarchar](50) NULL,
	[配图1拍摄人] [nvarchar](50) NULL,
	[配图2] [nvarchar](200) NULL,
	[配图2文件名] [nvarchar](50) NULL,
	[配图2拍摄地点] [nvarchar](50) NULL,
	[配图2描述] [nvarchar](50) NULL,
	[配图2拍摄人] [nvarchar](50) NULL,
	[配图3] [nvarchar](200) NULL,
	[配图3文件名] [nvarchar](50) NULL,
	[配图3拍摄地点] [nvarchar](50) NULL,
	[配图3描述] [nvarchar](50) NULL,
	[配图3拍摄人] [nvarchar](50) NULL,
 CONSTRAINT [PK_配图信息] PRIMARY KEY CLUSTERED 
(
	[编号] ASC,
	[种名] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[植物图片]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[植物图片]
AS
SELECT dbo.园林植物基本信息管理业务.编号, dbo.园林植物基本信息管理业务.种名, dbo.园林植物基本信息管理业务.科名, dbo.配图信息.配图1, dbo.配图信息.配图1文件名, 
            dbo.配图信息.配图1拍摄地点, dbo.配图信息.配图1描述, dbo.配图信息.配图1拍摄人
FROM    dbo.园林植物基本信息管理业务 INNER JOIN
            dbo.配图信息 ON dbo.园林植物基本信息管理业务.编号 = dbo.配图信息.编号 AND dbo.园林植物基本信息管理业务.种名 = dbo.配图信息.种名
GO
/****** Object:  Table [dbo].[数据更新]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[数据更新](
	[编号] [nvarchar](50) NOT NULL,
	[创建人员] [nvarchar](50) NOT NULL,
	[创建时间] [nvarchar](50) NOT NULL,
	[更新时间] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[更新信息]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[更新信息]
AS
SELECT dbo.园林植物基本信息管理业务.编号, dbo.园林植物基本信息管理业务.种名, dbo.数据更新.创建人员, dbo.数据更新.创建时间, dbo.数据更新.更新时间
FROM    dbo.数据更新 INNER JOIN
            dbo.园林植物基本信息管理业务 ON dbo.数据更新.编号 = dbo.园林植物基本信息管理业务.编号
GO
/****** Object:  Table [dbo].[病虫害]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[病虫害](
	[病虫害编号] [int] NOT NULL,
	[病虫害名称] [nvarchar](50) NULL,
	[植物编号] [int] NULL,
	[植物名称] [nvarchar](50) NULL,
	[药剂编号] [int] NULL,
	[药剂名称] [nvarchar](50) NULL,
	[受灾时间] [datetime] NULL,
	[受灾植物数量] [int] NULL,
	[受灾严重程度] [nvarchar](50) NULL,
	[防治方法] [nvarchar](50) NULL,
	[药剂用量] [decimal](10, 2) NULL,
	[作用期限] [int] NULL,
	[创建人员] [nvarchar](50) NULL,
	[创建时间] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[病虫害编号] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[病虫害防治措施]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[病虫害防治措施](
	[编号] [nvarchar](50) NOT NULL,
	[种名] [nvarchar](50) NOT NULL,
	[病名] [nvarchar](50) NOT NULL,
	[养护策略1] [nvarchar](50) NULL,
	[养护策略2] [nvarchar](50) NULL,
	[养护策略3] [nvarchar](50) NULL,
 CONSTRAINT [PK_病虫害防治措施] PRIMARY KEY CLUSTERED 
(
	[编号] ASC,
	[种名] ASC,
	[病名] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[对象设备]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[对象设备](
	[编号] [int] NOT NULL,
	[对象编号] [int] NULL,
	[设备编号] [int] NULL,
 CONSTRAINT [PK_对象设备] PRIMARY KEY CLUSTERED 
(
	[编号] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[对象指标]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[对象指标](
	[编号] [int] NOT NULL,
	[对象编号] [int] NULL,
	[指标编号] [int] NULL,
	[指标标准] [varchar](50) NULL,
 CONSTRAINT [PK_对象指标] PRIMARY KEY CLUSTERED 
(
	[编号] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[分布区域]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[分布区域](
	[种名] [nvarchar](50) NOT NULL,
	[省] [nvarchar](50) NULL,
	[市] [nvarchar](50) NULL,
	[县] [nvarchar](50) NULL,
 CONSTRAINT [PK_分布区域] PRIMARY KEY CLUSTERED 
(
	[种名] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[监测对象]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[监测对象](
	[对象编号] [int] NOT NULL,
	[植物名称] [varchar](50) NULL,
	[监测地点] [varchar](50) NULL,
 CONSTRAINT [PK_监测对象] PRIMARY KEY CLUSTERED 
(
	[对象编号] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[监测记录表]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[监测记录表](
	[记录编号] [int] IDENTITY(1,1) NOT NULL,
	[监测时间] [datetime] NULL,
	[监测地点] [varchar](50) NULL,
	[创建时间] [datetime] NULL,
	[更新时间] [datetime] NULL,
	[人员编号] [int] NULL,
	[设备编号] [int] NULL,
	[对象编号] [int] NULL,
	[指标编号] [int] NULL,
	[指标参数] [varchar](50) NULL,
	[是否异常] [varchar](50) NULL,
 CONSTRAINT [PK_监测记录表] PRIMARY KEY CLUSTERED 
(
	[记录编号] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[监测人员]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[监测人员](
	[人员编号] [int] NOT NULL,
	[姓名] [varchar](50) NULL,
 CONSTRAINT [PK_监测人员] PRIMARY KEY CLUSTERED 
(
	[人员编号] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[监测设备]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[监测设备](
	[设备编号] [int] NOT NULL,
 CONSTRAINT [PK_监测设备] PRIMARY KEY CLUSTERED 
(
	[设备编号] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[⁮监测指标]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[⁮监测指标](
	[指标编号] [int] NOT NULL,
	[指标名] [varchar](50) NULL,
 CONSTRAINT [PK_⁮监测指标] PRIMARY KEY CLUSTERED 
(
	[指标编号] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[设备指标]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[设备指标](
	[编号] [int] NOT NULL,
	[设备编号] [int] NULL,
	[指标编号] [int] NULL,
 CONSTRAINT [PK_设备指标] PRIMARY KEY CLUSTERED 
(
	[编号] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[用户]    Script Date: 2023/12/27 19:20:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[用户](
	[用户名] [nvarchar](50) NOT NULL,
	[密码] [nvarchar](50) NOT NULL,
	[权限] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[用户表]    Script Date: 2023/12/27 19:20:19 ******/
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
ALTER TABLE [dbo].[养护任务] ADD  DEFAULT (getdate()) FOR [创建时间]
GO
ALTER TABLE [dbo].[养护任务] ADD  DEFAULT (getdate()) FOR [更新时间]
GO
ALTER TABLE [dbo].[对象设备]  WITH CHECK ADD  CONSTRAINT [FK_对象设备_对象设备] FOREIGN KEY([设备编号])
REFERENCES [dbo].[监测设备] ([设备编号])
GO
ALTER TABLE [dbo].[对象设备] CHECK CONSTRAINT [FK_对象设备_对象设备]
GO
ALTER TABLE [dbo].[对象设备]  WITH CHECK ADD  CONSTRAINT [FK_对象设备_监测对象] FOREIGN KEY([对象编号])
REFERENCES [dbo].[监测对象] ([对象编号])
GO
ALTER TABLE [dbo].[对象设备] CHECK CONSTRAINT [FK_对象设备_监测对象]
GO
ALTER TABLE [dbo].[对象指标]  WITH CHECK ADD  CONSTRAINT [FK_对象指标_监测对象] FOREIGN KEY([对象编号])
REFERENCES [dbo].[监测对象] ([对象编号])
GO
ALTER TABLE [dbo].[对象指标] CHECK CONSTRAINT [FK_对象指标_监测对象]
GO
ALTER TABLE [dbo].[对象指标]  WITH CHECK ADD  CONSTRAINT [FK_对象指标_⁮监测指标] FOREIGN KEY([指标编号])
REFERENCES [dbo].[⁮监测指标] ([指标编号])
GO
ALTER TABLE [dbo].[对象指标] CHECK CONSTRAINT [FK_对象指标_⁮监测指标]
GO
ALTER TABLE [dbo].[监测记录表]  WITH CHECK ADD  CONSTRAINT [FK_监测记录表_监测对象] FOREIGN KEY([对象编号])
REFERENCES [dbo].[监测对象] ([对象编号])
GO
ALTER TABLE [dbo].[监测记录表] CHECK CONSTRAINT [FK_监测记录表_监测对象]
GO
ALTER TABLE [dbo].[监测记录表]  WITH CHECK ADD  CONSTRAINT [FK_监测记录表_监测人员] FOREIGN KEY([人员编号])
REFERENCES [dbo].[监测人员] ([人员编号])
GO
ALTER TABLE [dbo].[监测记录表] CHECK CONSTRAINT [FK_监测记录表_监测人员]
GO
ALTER TABLE [dbo].[监测记录表]  WITH CHECK ADD  CONSTRAINT [FK_监测记录表_监测设备] FOREIGN KEY([设备编号])
REFERENCES [dbo].[监测设备] ([设备编号])
GO
ALTER TABLE [dbo].[监测记录表] CHECK CONSTRAINT [FK_监测记录表_监测设备]
GO
ALTER TABLE [dbo].[监测记录表]  WITH CHECK ADD  CONSTRAINT [FK_监测记录表_⁮监测指标] FOREIGN KEY([指标编号])
REFERENCES [dbo].[⁮监测指标] ([指标编号])
GO
ALTER TABLE [dbo].[监测记录表] CHECK CONSTRAINT [FK_监测记录表_⁮监测指标]
GO
ALTER TABLE [dbo].[设备指标]  WITH CHECK ADD  CONSTRAINT [FK_设备指标_监测设备] FOREIGN KEY([设备编号])
REFERENCES [dbo].[监测设备] ([设备编号])
GO
ALTER TABLE [dbo].[设备指标] CHECK CONSTRAINT [FK_设备指标_监测设备]
GO
ALTER TABLE [dbo].[设备指标]  WITH CHECK ADD  CONSTRAINT [FK_设备指标_⁮监测指标] FOREIGN KEY([指标编号])
REFERENCES [dbo].[⁮监测指标] ([指标编号])
GO
ALTER TABLE [dbo].[设备指标] CHECK CONSTRAINT [FK_设备指标_⁮监测指标]
GO
ALTER TABLE [dbo].[养护任务]  WITH CHECK ADD FOREIGN KEY([病虫害编号])
REFERENCES [dbo].[病虫害] ([病虫害编号])
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "园林植物基本信息管理业务"
            Begin Extent = 
               Top = 10
               Left = 925
               Bottom = 230
               Right = 1161
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1174
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1354
         SortOrder = 1414
         GroupBy = 1350
         Filter = 1354
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'不同科名的植物'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'不同科名的植物'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "数据更新"
            Begin Extent = 
               Top = 10
               Left = 67
               Bottom = 230
               Right = 270
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "园林植物基本信息管理业务"
            Begin Extent = 
               Top = 10
               Left = 337
               Bottom = 230
               Right = 573
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'更新信息'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'更新信息'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "园林植物基本信息管理业务"
            Begin Extent = 
               Top = 10
               Left = 67
               Bottom = 230
               Right = 303
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "园林植物分类管理"
            Begin Extent = 
               Top = 10
               Left = 370
               Bottom = 230
               Right = 573
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "养护任务"
            Begin Extent = 
               Top = 10
               Left = 640
               Bottom = 230
               Right = 876
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'上级主管'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'上级主管'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "园林植物基本信息管理业务"
            Begin Extent = 
               Top = 10
               Left = 67
               Bottom = 230
               Right = 303
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "配图信息"
            Begin Extent = 
               Top = 10
               Left = 370
               Bottom = 230
               Right = 618
            End
            DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1174
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1354
         SortOrder = 1414
         GroupBy = 1350
         Filter = 1354
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'植物图片'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'植物图片'
GO
