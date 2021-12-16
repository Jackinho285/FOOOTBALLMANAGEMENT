USE [FOOTBALL_TEAM_MANAGEMENT_SYSTEM]
GO
/****** Object:  User [jack]    Script Date: 16.12.2021 13:06:42 ******/
CREATE USER [jack] FOR LOGIN [FMUser] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Schema [club]    Script Date: 16.12.2021 13:06:42 ******/
CREATE SCHEMA [club]
GO
/****** Object:  Schema [match]    Script Date: 16.12.2021 13:06:42 ******/
CREATE SCHEMA [match]
GO
/****** Object:  Schema [player]    Script Date: 16.12.2021 13:06:42 ******/
CREATE SCHEMA [player]
GO
/****** Object:  Schema [sp]    Script Date: 16.12.2021 13:06:42 ******/
CREATE SCHEMA [sp]
GO
/****** Object:  Schema [view]    Script Date: 16.12.2021 13:06:42 ******/
CREATE SCHEMA [view]
GO
/****** Object:  Table [player].[PLAYER_STATISTIC]    Script Date: 16.12.2021 13:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [player].[PLAYER_STATISTIC](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Goal] [int] NULL,
	[Assist] [int] NULL,
	[MatchCount] [int] NULL,
	[YellowCard] [int] NULL,
	[RedCard] [int] NULL,
	[PlayerId] [int] NOT NULL,
 CONSTRAINT [PK__PLAYER_S__3214EC07AD3F79CF] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [player].[PLAYERS]    Script Date: 16.12.2021 13:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [player].[PLAYERS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Surname] [nvarchar](50) NULL,
	[BirthDay] [datetime] NULL,
	[Country] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[Size] [int] NULL,
	[Weight] [int] NULL,
	[PositionId] [int] NOT NULL,
	[MarketValue] [int] NOT NULL,
	[Salary] [int] NOT NULL,
	[ClubId] [int] NOT NULL,
 CONSTRAINT [PK__STAFF__3214EC076D2C4534] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Top_Scorer]    Script Date: 16.12.2021 13:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Top_Scorer] AS
SELECT TOP(10) P.Name,P.Surname,PS.Goal FROM player.PLAYERS P
  JOIN [player].[PLAYER_STATISTIC] PS ON P.Id=PS.PlayerId
  ORDER BY PS.Goal DESC
GO
/****** Object:  View [dbo].[Top_Assists]    Script Date: 16.12.2021 13:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Top_Assists] AS
SELECT TOP(10) P.Name,P.Surname,PS.Assist FROM player.PLAYERS P
  JOIN [player].[PLAYER_STATISTIC] PS ON P.Id=PS.PlayerId
  ORDER BY PS.Assist DESC
GO
/****** Object:  View [dbo].[Top_Cards]    Script Date: 16.12.2021 13:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Top_Cards] AS
SELECT TOP(10) P.Name,P.Surname,PS.RedCard,PS.YellowCard FROM player.PLAYERS P
  JOIN [player].[PLAYER_STATISTIC] PS ON P.Id=PS.PlayerId
  ORDER BY PS.RedCard,PS.YellowCard DESC
GO
/****** Object:  Table [dbo].[STANDINGS]    Script Date: 16.12.2021 13:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STANDINGS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClubId] [int] NULL,
	[Played] [smallint] NULL,
	[Won] [smallint] NULL,
	[Drawn] [smallint] NULL,
	[Lost] [smallint] NULL,
	[GoalFours] [smallint] NULL,
	[GoalAgainst] [smallint] NULL,
	[GoalDifference] [smallint] NULL,
	[Points] [smallint] NULL,
 CONSTRAINT [PK_Standings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [club].[CLUB_INFORMATION]    Script Date: 16.12.2021 13:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [club].[CLUB_INFORMATION](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[StadiumId] [int] NOT NULL,
	[Founded] [datetime] NULL,
	[Country] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[FirstColor] [nvarchar](20) NULL,
	[SecondColor] [nvarchar](20) NULL,
 CONSTRAINT [PK__TEAM_INF__3214EC07D030B122] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Top_Team_Defense]    Script Date: 16.12.2021 13:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Top_Team_Defense] AS
SELECT TOP(10) CI.Name,CI.City,ST.GoalAgainst FROM [club].[CLUB_INFORMATION] CI 
  JOIN [dbo].[STANDINGS] ST ON CI.Id=ST.ClubId
  ORDER BY ST.GoalAgainst ASC
GO
/****** Object:  Table [match].[MATCH_STATISTICS]    Script Date: 16.12.2021 13:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [match].[MATCH_STATISTICS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Possession] [int] NOT NULL,
	[Attempts] [int] NULL,
	[Corners] [int] NULL,
	[Passes] [int] NOT NULL,
	[YellowCard] [int] NULL,
	[RedCard] [int] NULL,
	[Fouls] [int] NULL,
	[Offsides] [int] NULL,
	[MatchId] [int] NOT NULL,
	[Goal] [int] NOT NULL,
	[ClubId] [int] NULL,
 CONSTRAINT [PK__MATCH_ST__3214EC07E2869EBB] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [match].[MATCHS]    Script Date: 16.12.2021 13:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [match].[MATCHS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StadiumId] [int] NOT NULL,
	[RefereeId] [int] NOT NULL,
	[HomeClubId] [int] NOT NULL,
	[AwayClubId] [int] NOT NULL,
	[FanCount] [int] NULL,
 CONSTRAINT [PK__MATCHS__3214EC078F4388AD] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROFESSIONS]    Script Date: 16.12.2021 13:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROFESSIONS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](50) NULL,
 CONSTRAINT [PK__PROFESSI__3214EC0779E3A87F] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [club].[CLUB_EMPLOYEES]    Script Date: 16.12.2021 13:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [club].[CLUB_EMPLOYEES](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Surname] [nvarchar](50) NULL,
	[ContractDate] [datetime] NULL,
	[ContractEndDate] [datetime] NULL,
	[Country] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[ProfessionId] [int] NOT NULL,
	[Salary] [int] NOT NULL,
	[ClubId] [int] NOT NULL,
 CONSTRAINT [PK__CLUB_EMP__3214EC07533A827C] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Team_Coach_Statistic]    Script Date: 16.12.2021 13:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Team_Coach_Statistic] AS
SELECT 
        CE.[Name] AS MANAGER_NAME,
		CE.Surname AS MANAGER_SURNAME,
		CI.[Name] AS CLUB_NAME,
		AVG(MS.Goal) AS AVG_GOAL,
		AVG(MS.Passes) AS AVG_PASSES,
		AVG(MS.Possession) AS AVG_POSSESSION,
		(S.Points/S.Played) AS AVG_POINT 
FROM [club].[CLUB_EMPLOYEES] CE	
  JOIN [dbo].[PROFESSIONS] PR ON CE.ProfessionId=PR.Id
  JOIN [club].[CLUB_INFORMATION] CI ON CI.Id=CE.ClubId
  JOIN [match].[MATCHS] M ON M.AwayClubId=CI.Id
  JOIN [match].[MATCH_STATISTICS] MS ON MS.MatchId=M.Id AND MS.ClubId=CI.Id
  JOIN [dbo].[STANDINGS] S ON S.ClubId=CI.Id
WHERE PR.Id=1
GROUP BY CE.Name,CE.Surname,CI.Name,S.Points,S.Played
GO
/****** Object:  Table [club].[STADIUMS]    Script Date: 16.12.2021 13:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [club].[STADIUMS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[Capacity] [int] NOT NULL,
	[Founded] [datetime] NULL,
 CONSTRAINT [PK__STADIUMS__3214EC0706064EC2] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[REFEREES]    Script Date: 16.12.2021 13:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REFEREES](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Surname] [nvarchar](50) NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
 CONSTRAINT [PK__REFEREES__3214EC07FD4DB20F] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [match].[MATCH_PLAYER_STATISTIC]    Script Date: 16.12.2021 13:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [match].[MATCH_PLAYER_STATISTIC](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Goal] [int] NULL,
	[Assists] [int] NULL,
	[YellowCard] [int] NULL,
	[RedCard] [int] NULL,
	[RunningDistance] [int] NULL,
	[PlayerId] [int] NOT NULL,
	[MatchId] [int] NOT NULL,
 CONSTRAINT [PK__MATCH_PL__3214EC076DD1A598] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [player].[INJURIES]    Script Date: 16.12.2021 13:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [player].[INJURIES](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Diognosis] [nvarchar](50) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[PlayerId] [int] NOT NULL,
 CONSTRAINT [PK__INJURIES__3214EC0777C81298] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [player].[MATCH_PLAYERS]    Script Date: 16.12.2021 13:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [player].[MATCH_PLAYERS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PlayerId] [int] NOT NULL,
	[MatchId] [int] NOT NULL,
	[ClubId] [int] NOT NULL,
 CONSTRAINT [PK__MATCH_PL__3214EC07A59C5A77] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [player].[POSITIONS]    Script Date: 16.12.2021 13:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [player].[POSITIONS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](50) NULL,
 CONSTRAINT [PK__POSITION__3214EC07A1E8B09D] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [club].[CLUB_EMPLOYEES] ON 

INSERT [club].[CLUB_EMPLOYEES] ([Id], [Name], [Surname], [ContractDate], [ContractEndDate], [Country], [City], [ProfessionId], [Salary], [ClubId]) VALUES (1, N'Abdullah', N'Avcı', CAST(N'2020-01-01T00:00:00.000' AS DateTime), CAST(N'2023-01-01T00:00:00.000' AS DateTime), N'Turkey', N'Istanbul', 1, 500000, 2)
INSERT [club].[CLUB_EMPLOYEES] ([Id], [Name], [Surname], [ContractDate], [ContractEndDate], [Country], [City], [ProfessionId], [Salary], [ClubId]) VALUES (2, N'Sergen', N'Yalçın', CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2021-12-10T00:00:00.000' AS DateTime), N'Turkey', N'Istanbul', 1, 400000, 1)
SET IDENTITY_INSERT [club].[CLUB_EMPLOYEES] OFF
GO
SET IDENTITY_INSERT [club].[CLUB_INFORMATION] ON 

INSERT [club].[CLUB_INFORMATION] ([Id], [Name], [StadiumId], [Founded], [Country], [City], [FirstColor], [SecondColor]) VALUES (1, N'BESIKTAS', 1, CAST(N'1903-01-01T00:00:00.000' AS DateTime), N'TURKEY', N'ISTANBUL', N'BLACK', N'WHITE')
INSERT [club].[CLUB_INFORMATION] ([Id], [Name], [StadiumId], [Founded], [Country], [City], [FirstColor], [SecondColor]) VALUES (2, N'TRABZONSPOR', 2, CAST(N'1967-01-01T00:00:00.000' AS DateTime), N'TURKEY', N'TRABZON', N'BURGUNDY', N'BLUE')
SET IDENTITY_INSERT [club].[CLUB_INFORMATION] OFF
GO
SET IDENTITY_INSERT [club].[STADIUMS] ON 

INSERT [club].[STADIUMS] ([Id], [Name], [Country], [City], [Capacity], [Founded]) VALUES (1, N'VODOFONE PARK', N'TURKEY', N'ISTANBUL', 50000, CAST(N'2016-01-01T00:00:00.000' AS DateTime))
INSERT [club].[STADIUMS] ([Id], [Name], [Country], [City], [Capacity], [Founded]) VALUES (2, N'AKYAZI STADYUM', N'TURKEY', N'TRABZON', 40061, CAST(N'2016-01-01T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [club].[STADIUMS] OFF
GO
SET IDENTITY_INSERT [dbo].[PROFESSIONS] ON 

INSERT [dbo].[PROFESSIONS] ([Id], [Name], [Description]) VALUES (1, N'Manager', N'Team Coach')
INSERT [dbo].[PROFESSIONS] ([Id], [Name], [Description]) VALUES (2, N'Presedent', N'Team Owner')
INSERT [dbo].[PROFESSIONS] ([Id], [Name], [Description]) VALUES (3, N'Scout', N'Find Player')
SET IDENTITY_INSERT [dbo].[PROFESSIONS] OFF
GO
SET IDENTITY_INSERT [dbo].[REFEREES] ON 

INSERT [dbo].[REFEREES] ([Id], [Name], [Surname], [StartDate], [EndDate]) VALUES (2, N'ALİ', N'ŞANSALAN', CAST(N'2020-01-01T00:00:00.000' AS DateTime), CAST(N'2029-01-01T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[REFEREES] OFF
GO
SET IDENTITY_INSERT [dbo].[STANDINGS] ON 

INSERT [dbo].[STANDINGS] ([Id], [ClubId], [Played], [Won], [Drawn], [Lost], [GoalFours], [GoalAgainst], [GoalDifference], [Points]) VALUES (1, 2, 1, 1, 0, 0, 6, 2, 4, 3)
INSERT [dbo].[STANDINGS] ([Id], [ClubId], [Played], [Won], [Drawn], [Lost], [GoalFours], [GoalAgainst], [GoalDifference], [Points]) VALUES (2, 1, 1, 0, 0, 1, 4, 6, -2, 0)
SET IDENTITY_INSERT [dbo].[STANDINGS] OFF
GO
SET IDENTITY_INSERT [player].[PLAYERS] ON 

INSERT [player].[PLAYERS] ([Id], [Name], [Surname], [BirthDay], [Country], [City], [Size], [Weight], [PositionId], [MarketValue], [Salary], [ClubId]) VALUES (2, N'MAREK', N'HAMSIK', CAST(N'1985-01-01T00:00:00.000' AS DateTime), N'SLOVAKIA', N'Banská Bystrica', 185, 80, 3, 1000000, 1500000, 2)
INSERT [player].[PLAYERS] ([Id], [Name], [Surname], [BirthDay], [Country], [City], [Size], [Weight], [PositionId], [MarketValue], [Salary], [ClubId]) VALUES (3, N'GÜVEN', N'YALÇIN', CAST(N'1999-01-01T00:00:00.000' AS DateTime), N'GERMANY', N'Düsseldorf', 180, 90, 4, 50000, 20000, 1)
SET IDENTITY_INSERT [player].[PLAYERS] OFF
GO
SET IDENTITY_INSERT [player].[POSITIONS] ON 

INSERT [player].[POSITIONS] ([Id], [Name], [Description]) VALUES (1, N'DOS', N'DEFANSİF ORTA SAHA')
INSERT [player].[POSITIONS] ([Id], [Name], [Description]) VALUES (2, N'OOS', N'OFANSIK ORTA SAHA')
INSERT [player].[POSITIONS] ([Id], [Name], [Description]) VALUES (3, N'MO', N'MERKEZ ORTA SAHA')
INSERT [player].[POSITIONS] ([Id], [Name], [Description]) VALUES (4, N'ST', N'SANTRAFOR')
SET IDENTITY_INSERT [player].[POSITIONS] OFF
GO
ALTER TABLE [club].[CLUB_EMPLOYEES]  WITH CHECK ADD  CONSTRAINT [FK_CLUB_EMPLOYEES_CLUB_INFORMATION] FOREIGN KEY([ClubId])
REFERENCES [club].[CLUB_INFORMATION] ([Id])
GO
ALTER TABLE [club].[CLUB_EMPLOYEES] CHECK CONSTRAINT [FK_CLUB_EMPLOYEES_CLUB_INFORMATION]
GO
ALTER TABLE [club].[CLUB_EMPLOYEES]  WITH CHECK ADD  CONSTRAINT [FK_CLUB_EMPLOYEES_PROFESSIONS] FOREIGN KEY([ProfessionId])
REFERENCES [dbo].[PROFESSIONS] ([Id])
GO
ALTER TABLE [club].[CLUB_EMPLOYEES] CHECK CONSTRAINT [FK_CLUB_EMPLOYEES_PROFESSIONS]
GO
ALTER TABLE [club].[CLUB_INFORMATION]  WITH CHECK ADD  CONSTRAINT [FK_CLUB_INFORMATION_STADIUMS] FOREIGN KEY([StadiumId])
REFERENCES [club].[STADIUMS] ([Id])
GO
ALTER TABLE [club].[CLUB_INFORMATION] CHECK CONSTRAINT [FK_CLUB_INFORMATION_STADIUMS]
GO
ALTER TABLE [match].[MATCH_PLAYER_STATISTIC]  WITH CHECK ADD  CONSTRAINT [FK_MATCH_PLAYER_STATISTIC_MATCHS] FOREIGN KEY([MatchId])
REFERENCES [match].[MATCHS] ([Id])
GO
ALTER TABLE [match].[MATCH_PLAYER_STATISTIC] CHECK CONSTRAINT [FK_MATCH_PLAYER_STATISTIC_MATCHS]
GO
ALTER TABLE [match].[MATCH_PLAYER_STATISTIC]  WITH CHECK ADD  CONSTRAINT [FK_MATCH_PLAYER_STATISTIC_PLAYERS] FOREIGN KEY([PlayerId])
REFERENCES [player].[PLAYERS] ([Id])
GO
ALTER TABLE [match].[MATCH_PLAYER_STATISTIC] CHECK CONSTRAINT [FK_MATCH_PLAYER_STATISTIC_PLAYERS]
GO
ALTER TABLE [match].[MATCH_STATISTICS]  WITH CHECK ADD  CONSTRAINT [FK_MATCH_STATISTICS_CLUB_INFORMATION] FOREIGN KEY([ClubId])
REFERENCES [club].[CLUB_INFORMATION] ([Id])
GO
ALTER TABLE [match].[MATCH_STATISTICS] CHECK CONSTRAINT [FK_MATCH_STATISTICS_CLUB_INFORMATION]
GO
ALTER TABLE [match].[MATCH_STATISTICS]  WITH CHECK ADD  CONSTRAINT [FK_MATCH_STATISTICS_MATCHS] FOREIGN KEY([MatchId])
REFERENCES [match].[MATCHS] ([Id])
GO
ALTER TABLE [match].[MATCH_STATISTICS] CHECK CONSTRAINT [FK_MATCH_STATISTICS_MATCHS]
GO
ALTER TABLE [match].[MATCHS]  WITH CHECK ADD  CONSTRAINT [FK_MATCHS_CLUB_INFORMATION] FOREIGN KEY([HomeClubId])
REFERENCES [club].[CLUB_INFORMATION] ([Id])
GO
ALTER TABLE [match].[MATCHS] CHECK CONSTRAINT [FK_MATCHS_CLUB_INFORMATION]
GO
ALTER TABLE [match].[MATCHS]  WITH CHECK ADD  CONSTRAINT [FK_MATCHS_CLUB_INFORMATION1] FOREIGN KEY([AwayClubId])
REFERENCES [club].[CLUB_INFORMATION] ([Id])
GO
ALTER TABLE [match].[MATCHS] CHECK CONSTRAINT [FK_MATCHS_CLUB_INFORMATION1]
GO
ALTER TABLE [match].[MATCHS]  WITH CHECK ADD  CONSTRAINT [FK_MATCHS_REFEREES] FOREIGN KEY([RefereeId])
REFERENCES [dbo].[REFEREES] ([Id])
GO
ALTER TABLE [match].[MATCHS] CHECK CONSTRAINT [FK_MATCHS_REFEREES]
GO
ALTER TABLE [match].[MATCHS]  WITH CHECK ADD  CONSTRAINT [FK_MATCHS_STADIUMS] FOREIGN KEY([StadiumId])
REFERENCES [club].[STADIUMS] ([Id])
GO
ALTER TABLE [match].[MATCHS] CHECK CONSTRAINT [FK_MATCHS_STADIUMS]
GO
ALTER TABLE [player].[INJURIES]  WITH CHECK ADD  CONSTRAINT [FK_INJURIES_PLAYERS] FOREIGN KEY([PlayerId])
REFERENCES [player].[PLAYERS] ([Id])
GO
ALTER TABLE [player].[INJURIES] CHECK CONSTRAINT [FK_INJURIES_PLAYERS]
GO
ALTER TABLE [player].[MATCH_PLAYERS]  WITH CHECK ADD  CONSTRAINT [FK_MATCH_PLAYERS_CLUB_INFORMATION] FOREIGN KEY([ClubId])
REFERENCES [club].[CLUB_INFORMATION] ([Id])
GO
ALTER TABLE [player].[MATCH_PLAYERS] CHECK CONSTRAINT [FK_MATCH_PLAYERS_CLUB_INFORMATION]
GO
ALTER TABLE [player].[MATCH_PLAYERS]  WITH CHECK ADD  CONSTRAINT [FK_MATCH_PLAYERS_MATCHS] FOREIGN KEY([MatchId])
REFERENCES [match].[MATCHS] ([Id])
GO
ALTER TABLE [player].[MATCH_PLAYERS] CHECK CONSTRAINT [FK_MATCH_PLAYERS_MATCHS]
GO
ALTER TABLE [player].[MATCH_PLAYERS]  WITH CHECK ADD  CONSTRAINT [FK_MATCH_PLAYERS_PLAYERS] FOREIGN KEY([PlayerId])
REFERENCES [player].[PLAYERS] ([Id])
GO
ALTER TABLE [player].[MATCH_PLAYERS] CHECK CONSTRAINT [FK_MATCH_PLAYERS_PLAYERS]
GO
ALTER TABLE [player].[PLAYER_STATISTIC]  WITH CHECK ADD  CONSTRAINT [FK_PLAYER_STATISTIC_PLAYERS] FOREIGN KEY([PlayerId])
REFERENCES [player].[PLAYERS] ([Id])
GO
ALTER TABLE [player].[PLAYER_STATISTIC] CHECK CONSTRAINT [FK_PLAYER_STATISTIC_PLAYERS]
GO
ALTER TABLE [player].[PLAYERS]  WITH CHECK ADD  CONSTRAINT [FK_PLAYERS_CLUB_INFORMATION] FOREIGN KEY([ClubId])
REFERENCES [club].[CLUB_INFORMATION] ([Id])
GO
ALTER TABLE [player].[PLAYERS] CHECK CONSTRAINT [FK_PLAYERS_CLUB_INFORMATION]
GO
ALTER TABLE [player].[PLAYERS]  WITH CHECK ADD  CONSTRAINT [FK_PLAYERS_POSITIONS] FOREIGN KEY([PositionId])
REFERENCES [player].[POSITIONS] ([Id])
GO
ALTER TABLE [player].[PLAYERS] CHECK CONSTRAINT [FK_PLAYERS_POSITIONS]
GO
/****** Object:  StoredProcedure [sp].[ADD_CLUB]    Script Date: 16.12.2021 13:06:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [sp].[ADD_CLUB]
   (@Name nvarchar(50),
   @StadiumId int,
   @Founded datetime,
   @Country nvarchar(50),
   @City nvarchar(50),
   @FirstColor nvarchar(50),
   @SecondColor nvarchar(50))
   
AS
BEGIN

INSERT INTO CLUB_INFORMATION([Name],
					 StadiumId,
					 Founded,
					 Country,
					 City,
					 FirstColor,
					 SecondColor
					 )

			VALUES  (@Name,
			         @StadiumId,
					 @Founded,
					 @Country,
					 @City,
					 @FirstColor,
					 @SecondColor)
					 

END
GO
/****** Object:  StoredProcedure [sp].[ADD_INJURY]    Script Date: 16.12.2021 13:06:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [sp].[ADD_INJURY]
   (@Diognosis nvarchar(50),
   @StartDate datetime,
   @EndDate datetime,
   @PlayerId int
   )
   
AS
BEGIN

INSERT INTO INJURIES(Diognosis,
					 StartDate,
					 EndDate,
					 PlayerId
					 )

			VALUES  (@Diognosis,
			         @StartDate,
					 @EndDate,
					 @PlayerId
					 )
					 					
END
GO
/****** Object:  StoredProcedure [sp].[ADD_PLAYER]    Script Date: 16.12.2021 13:06:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [sp].[ADD_PLAYER]
   (@Name nvarchar(50),
   @Surname nvarchar(50),
   @BirthDay datetime,
   @Country nvarchar(50),
   @City nvarchar(50),
   @Size int,
   @Weight int,
   @PositionId int,
   @MarketValue int,
   @Salary int,
   @ClubId int)
   
AS
BEGIN

INSERT INTO PLAYERS ([Name],
					 Surname,
					 BirthDay,
					 Country,
					 City,
					 Size,
					 [Weight],
					 PositionId,
					 MarketValue,
					 Salary,
					 ClubId
					 )
			VALUES  (@Name,
			         @Surname,
					 @BirthDay,
					 @Country,
					 @City,
					 @Size,
					 @Weight,
					 @PositionId,
					 @MarketValue,
					 @Salary,
					 @ClubId)

END					 

GO
/****** Object:  StoredProcedure [sp].[ADD_POSITION]    Script Date: 16.12.2021 13:06:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [sp].[ADD_POSITION]
   (@Name nvarchar(50),
   @Description nvarchar(50)
   )
   
AS
BEGIN

INSERT INTO POSITIONS([Name],
					 [Description]
					 )

			VALUES  (@Name,
			         @Description
					 )
					 

END
GO
/****** Object:  StoredProcedure [sp].[ADD_REFEREE]    Script Date: 16.12.2021 13:06:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [sp].[ADD_REFEREE]
   (@Name nvarchar(50),
   @Surname nvarchar(50),
   @StartDate datetime,
   @EndDate datetime
   )
  
   
AS
BEGIN

INSERT INTO REFEREES([Name],
					 Surname,
					 StartDate,
					 EndDate
					 )

			VALUES  (@Name,
			         @Surname,
					 @StartDate,
					 @EndDate
					 )
					 

END
GO
/****** Object:  StoredProcedure [sp].[ADD_STADIUM]    Script Date: 16.12.2021 13:06:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [sp].[ADD_STADIUM]
   (@Name nvarchar(50),
   @Country nvarchar(50),
   @City nvarchar(50),
   @Capacity int,
   @Founded datetime
   )
   
AS
BEGIN

INSERT INTO STADIUMS([Name],
					 Country,
					 City,
					 Capacity,
					 Founded
					 )

			VALUES  (@Name,
					 @Country,
					 @City,
					 @Capacity,
					 @Founded)
					 

END
GO
/****** Object:  StoredProcedure [sp].[DELETE_CLUB]    Script Date: 16.12.2021 13:06:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [sp].[DELETE_CLUB]

@ClubId int

AS
BEGIN
DELETE CLUB_INFORMATION WHERE Id=@ClubId
END
GO
/****** Object:  StoredProcedure [sp].[DELETE_INJURY]    Script Date: 16.12.2021 13:06:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [sp].[DELETE_INJURY]

@InjuryId int

AS
BEGIN
DELETE INJURIES WHERE Id=@InjuryId
END
GO
/****** Object:  StoredProcedure [sp].[DELETE_PLAYER]    Script Date: 16.12.2021 13:06:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [sp].[DELETE_PLAYER]

@PlayerId int

AS
BEGIN
DELETE PLAYERS WHERE Id=@PlayerId
END
GO
/****** Object:  StoredProcedure [sp].[DELETE_POSITION]    Script Date: 16.12.2021 13:06:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [sp].[DELETE_POSITION]

@PositionId int

AS
BEGIN
DELETE POSITIONS WHERE Id=@PositionId
END
GO
/****** Object:  StoredProcedure [sp].[DELETE_REFEREE]    Script Date: 16.12.2021 13:06:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [sp].[DELETE_REFEREE]

@RefereeId int

AS
BEGIN
DELETE REFEREES WHERE Id=@RefereeId
END
GO
/****** Object:  StoredProcedure [sp].[DELETE_STADIUM]    Script Date: 16.12.2021 13:06:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [sp].[DELETE_STADIUM]

@StadıumId int

AS
BEGIN
DELETE STADIUMS WHERE Id=@StadıumId
END
GO
/****** Object:  StoredProcedure [sp].[UPDATE_PLAYER]    Script Date: 16.12.2021 13:06:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [sp].[UPDATE_PLAYER]
  (@PositionId int,
   @MarketValue int,
   @Salary int,
   @ClubId int,
   @PlayerId int)
   
AS
BEGIN

UPDATE PLAYERS SET   PositionId=@PositionId,
					 MarketValue=@MarketValue,
					 Salary=@Salary,
					 ClubId=@ClubId
WHERE Id=@PlayerId					 
	
END					 
GO
/****** Object:  StoredProcedure [sp].[UPDATE_POSITION]    Script Date: 16.12.2021 13:06:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [sp].[UPDATE_POSITION]
  (
  @Description nvarchar(50)
  )
   
AS
BEGIN

UPDATE POSITIONS SET Description=@Description
					 
WHERE Id=@Description					 
	
END					 
GO
/****** Object:  StoredProcedure [sp].[UPDATE_STADIUM]    Script Date: 16.12.2021 13:06:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [sp].[UPDATE_STADIUM]
  (@Name int,
   @Capacity int,
   @StadıumId int
  )
   
AS
BEGIN

UPDATE STADIUMS SET  [Name]=@Name,
					 Capacity=@Capacity					 
WHERE Id=@StadıumId					 
	
END
GO
