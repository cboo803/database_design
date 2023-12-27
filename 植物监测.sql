USE [plant]
GO
/****** Object:  Table [dbo].[对象设备]    Script Date: 2023/12/27 21:08:15 ******/
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
/****** Object:  Table [dbo].[对象指标]    Script Date: 2023/12/27 21:08:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[对象指标](
	[编号] [int] NOT NULL,
	[对象编号] [int] NULL,
	[指标编号] [int] NULL,
	[指标标准] [float] NULL,
 CONSTRAINT [PK_对象指标] PRIMARY KEY CLUSTERED 
(
	[编号] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[监测对象]    Script Date: 2023/12/27 21:08:15 ******/
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
/****** Object:  Table [dbo].[监测记录表]    Script Date: 2023/12/27 21:08:15 ******/
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
	[指标参数] [float] NULL,
	[是否异常] [varchar](50) NULL,
 CONSTRAINT [PK_监测记录表] PRIMARY KEY CLUSTERED 
(
	[记录编号] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[监测人员]    Script Date: 2023/12/27 21:08:15 ******/
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
/****** Object:  Table [dbo].[监测设备]    Script Date: 2023/12/27 21:08:15 ******/
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
/****** Object:  Table [dbo].[⁮监测指标]    Script Date: 2023/12/27 21:08:15 ******/
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
/****** Object:  Table [dbo].[设备指标]    Script Date: 2023/12/27 21:08:15 ******/
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
