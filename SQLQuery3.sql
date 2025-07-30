USE [schedule]
GO
/****** Object:  User [GUR\dev]    Script Date: 30/07/2025 19:40:56 ******/
CREATE USER [GUR\dev] FOR LOGIN [GUR\dev] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[assignments]    Script Date: 30/07/2025 19:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[assignments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[teacher_id] [nvarchar](20) NOT NULL,
	[class_id] [nvarchar](20) NOT NULL,
	[subject_id] [int] NOT NULL,
	[_day] [int] NOT NULL,
	[_hour] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[classes]    Script Date: 30/07/2025 19:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[classes](
	[id] [nvarchar](20) NOT NULL,
	[class_name] [nvarchar](20) NOT NULL,
	[grade_level] [int] NOT NULL,
	[homeroom_teacher_id] [nvarchar](20) NULL,
	[min_hours_per_day] [int] NULL,
	[max_hours_per_day] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[schedules]    Script Date: 30/07/2025 19:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[schedules](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[schedule_name] [nvarchar](20) NOT NULL,
	[semester] [nvarchar](2) NOT NULL,
	[_year] [int] NOT NULL,
	[is_active] [bit] NOT NULL,
	[max_days_per_week] [int] NULL,
	[max_hours_per_day] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[subject_requirements]    Script Date: 30/07/2025 19:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subject_requirements](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[class_id] [nvarchar](20) NOT NULL,
	[subject_id] [int] NOT NULL,
	[hours_per_week] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[subjects]    Script Date: 30/07/2025 19:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subjects](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[subject_name] [nvarchar](20) NOT NULL,
	[grade_level] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[teacher_subjects]    Script Date: 30/07/2025 19:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[teacher_subjects](
	[teacher_id] [nvarchar](20) NULL,
	[subject_id] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[teachers]    Script Date: 30/07/2025 19:40:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[teachers](
	[id] [nvarchar](20) NOT NULL,
	[teacher_name] [nvarchar](20) NOT NULL,
	[preferred_day_off] [int] NULL,
	[max_hours_per_day] [int] NULL,
	[max_hours_per_week] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[classes] ADD  DEFAULT ((0)) FOR [min_hours_per_day]
GO
ALTER TABLE [dbo].[classes] ADD  DEFAULT ((8)) FOR [max_hours_per_day]
GO
ALTER TABLE [dbo].[schedules] ADD  DEFAULT ((5)) FOR [max_days_per_week]
GO
ALTER TABLE [dbo].[schedules] ADD  DEFAULT ((8)) FOR [max_hours_per_day]
GO
ALTER TABLE [dbo].[assignments]  WITH CHECK ADD FOREIGN KEY([class_id])
REFERENCES [dbo].[classes] ([id])
GO
ALTER TABLE [dbo].[assignments]  WITH CHECK ADD FOREIGN KEY([subject_id])
REFERENCES [dbo].[subjects] ([id])
GO
ALTER TABLE [dbo].[assignments]  WITH CHECK ADD FOREIGN KEY([teacher_id])
REFERENCES [dbo].[teachers] ([id])
GO
ALTER TABLE [dbo].[classes]  WITH CHECK ADD FOREIGN KEY([homeroom_teacher_id])
REFERENCES [dbo].[teachers] ([id])
GO
ALTER TABLE [dbo].[subject_requirements]  WITH CHECK ADD FOREIGN KEY([class_id])
REFERENCES [dbo].[classes] ([id])
GO
ALTER TABLE [dbo].[subject_requirements]  WITH CHECK ADD FOREIGN KEY([subject_id])
REFERENCES [dbo].[subjects] ([id])
GO
ALTER TABLE [dbo].[teacher_subjects]  WITH CHECK ADD FOREIGN KEY([subject_id])
REFERENCES [dbo].[subjects] ([id])
GO
ALTER TABLE [dbo].[teacher_subjects]  WITH CHECK ADD FOREIGN KEY([teacher_id])
REFERENCES [dbo].[teachers] ([id])
GO
