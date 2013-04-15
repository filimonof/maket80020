USE [m80020]
GO
/****** Object:  Table [dbo].[m80020_IN_Header]    Script Date: 09/11/2012 11:24:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[m80020_IN_Header](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[number] [int] NOT NULL,
	[day] [nchar](8) NOT NULL,
	[timestamp] [nchar](14) NOT NULL,
	[daylightsavingtime] [nchar](1) NOT NULL,
	[inn] [nvarchar](50) NOT NULL,
	[name] [nvarchar](250) NOT NULL,
	[comment] [ntext] NULL,
 CONSTRAINT [PK_m80020_IN_Header] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblMaket80020SubscribeCompany]    Script Date: 09/11/2012 11:24:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMaket80020SubscribeCompany](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Enabled] [int] NULL,
	[Email] [nvarchar](250) NULL,
	[FormatFileMaket] [nvarchar](250) NULL,
	[SendNotification] [int] NULL,
	[FormatFileNotification] [nvarchar](250) NULL,
 CONSTRAINT [PK_tblMaket80020SubscribeCompany] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblMaket80020ParamPoint]    Script Date: 09/11/2012 11:24:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMaket80020ParamPoint](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[AreaID] [int] NOT NULL,
	[code] [nvarchar](50) NULL,
	[codefrom] [nvarchar](50) NULL,
	[codeto] [nvarchar](50) NULL,
	[NameObj] [nvarchar](50) NULL,
	[NameParam] [nvarchar](50) NULL,
	[NamePoint] [nvarchar](50) NULL,
	[Enabled] [int] NOT NULL,
	[koef] [int] NOT NULL,
	[IsSK] [int] NULL,
	[SK_TI] [int] NULL,
	[SK_Arch] [int] NULL,
	[INN_from] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblMaket80020ParamPoint] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblMaket80020Options]    Script Date: 09/11/2012 11:24:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMaket80020Options](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](250) NULL,
	[value] [nvarchar](250) NULL,
 CONSTRAINT [PK_tblMaket80020Options] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblMaket80020Log]    Script Date: 09/11/2012 11:24:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMaket80020Log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [int] NULL,
	[DateEvent] [smalldatetime] NULL CONSTRAINT [DF_tblMaket80020Log_DateEvent]  DEFAULT (getdate()),
	[DateFile] [smalldatetime] NULL,
	[INNFile] [nvarchar](10) NULL,
	[NumberFile] [int] NULL,
	[Comment] [ntext] NULL,
 CONSTRAINT [PK_tblMaket80020Log] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblMaket80020Area]    Script Date: 09/11/2012 11:24:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMaket80020Area](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[INN] [nvarchar](50) NULL,
	[Enabled] [int] NOT NULL,
 CONSTRAINT [PK_tblMaket80020Area] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[m80020_TypePoint]    Script Date: 09/11/2012 11:24:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[m80020_TypePoint](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_m80020_TypePoint] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[m80020_Value]    Script Date: 09/11/2012 11:24:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[m80020_Value](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[headerID] [int] NOT NULL,
	[areaINN] [nvarchar](50) NOT NULL,
	[typePoint] [int] NOT NULL,
	[channelCode] [nvarchar](50) NOT NULL,
	[pointCode1] [nvarchar](50) NOT NULL,
	[pointCode2] [nvarchar](50) NOT NULL,
	[start] [nchar](4) NOT NULL,
	[end] [nchar](4) NOT NULL,
	[summer] [int] NOT NULL,
	[value] [int] NOT NULL,
	[status] [int] NOT NULL,
	[errofmeasuring] [nvarchar](50) NULL,
	[exstendedstatus] [nvarchar](50) NULL,
	[param1] [nvarchar](50) NULL,
	[param2] [nvarchar](50) NULL,
	[param3] [nvarchar](50) NULL,
 CONSTRAINT [PK_m80020_Value] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[m80020_PlanCreateMaket]    Script Date: 09/11/2012 11:24:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[m80020_PlanCreateMaket](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[paramID] [int] NOT NULL,
	[koef] [int] NOT NULL,
	[area] [nvarchar](50) NOT NULL,
	[type] [int] NOT NULL,
	[code1] [nvarchar](50) NOT NULL,
	[code2] [nvarchar](50) NOT NULL,
	[channel] [nvarchar](50) NOT NULL,
	[inn] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_m80020_PlanCreateMaket] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[m80020_Area]    Script Date: 09/11/2012 11:24:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[m80020_Area](
	[inn] [nvarchar](50) NOT NULL,
	[name] [nvarchar](250) NOT NULL,
	[timezone] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[m80020_Channel]    Script Date: 09/11/2012 11:24:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[m80020_Channel](
	[areaINN] [nvarchar](50) NOT NULL,
	[pointCode] [nvarchar](50) NOT NULL,
	[typePoint] [int] NOT NULL,
	[code] [nvarchar](50) NOT NULL,
	[desc] [nvarchar](250) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[m80020_Point]    Script Date: 09/11/2012 11:24:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[m80020_Point](
	[code1] [nvarchar](50) NOT NULL,
	[code2] [nvarchar](50) NOT NULL,
	[areaINN] [nvarchar](50) NOT NULL,
	[typePoint] [int] NOT NULL,
	[name] [nvarchar](250) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[m80020_CreateMaket]    Script Date: 09/11/2012 11:24:02 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE        PROCEDURE [dbo].[m80020_CreateMaket] 
(
	@dt DATETIME,
	@paramID INT,
	@error NVARCHAR(250) OUTPUT
)
AS
BEGIN

	SET NOCOUNT ON
	
	SET @error = ''

	DECLARE @id INT

--

	IF EXISTS (SELECT * FROM dbo.sysobjects WHERE [id] = OBJECT_ID(N'#tmp') AND OBJECTPROPERTY([id], N'IsUserTable') = 1)
		DROP TABLE #tmp
	CREATE TABLE #tmp
	(		
		[start] NCHAR(4) NOT NULL,
		[end] NCHAR(4) NOT NULL,
		[summer] INT NOT NULL DEFAULT 0,
		[SumStatus] INT NOT NULL DEFAULT 0,
		[Value] INT NULL,
		[startGroup] NCHAR(2) NOT NULL			 -- для часовой разбивки
	)ON [PRIMARY]

	DECLARE @sql NVARCHAR(4000)

	DECLARE @koef INT,
		@area NVARCHAR(50),
		@type NVARCHAR(50),
		@code1 NVARCHAR(50),
		@code2 NVARCHAR(50),
		@channel NVARCHAR(50),
		@inn NVARCHAR(50)
	DECLARE cursorPlan CURSOR FOR
		SELECT koef, area, type, code1, code2, channel , inn
		FROM [m80020_PlanCreateMaket] 
		WHERE paramID = @paramID
	OPEN cursorPlan
	FETCH NEXT FROM cursorPlan INTO @koef, @area, @type, @code1, @code2, @channel, @inn
	WHILE (@@fetch_status <> -1)
	BEGIN
		IF (@@fetch_status <> -2)
		BEGIN

			SELECT TOP 1 @id = [id] 
			FROM dbo.m80020_IN_Header 
			WHERE inn = @inn AND [day] = CONVERT(NCHAR(8), @dt, 112)   -- 112 - это формат yyyymmdd
			ORDER BY number DESC

			IF @id IS NULL
			BEGIN
				SET @error = 'Нет данных на предприятие с ИНН ' + @inn + ' за дату ' + CONVERT(NCHAR(10), @dt, 104) 
				-- 104 - это формат dd.mm.yyyy
				CLOSE cursorPlan
				DEALLOCATE cursorPlan
				RETURN 
			END

--todo если плана выполнения нету, то взять данные тлько по INN всё просуммировав, и ниипёт

			SET @sql =' INSERT INTO #tmp '
				+ ' SELECT [start], [end], [summer], SUM([status]) AS SumStatus, SUM('+CAST(@koef AS VARCHAR(50))+' * [value]) AS Value, LEFT([start],2) AS startGroup FROM m80020_Value WHERE '
				+ '  [headerID] = ' + CAST(@id AS NVARCHAR(50))  
				+ '  AND ( 1=1 '
			IF @area <> '' SET @sql = @sql + 'AND  areaINN = ''' + @area + ''''
			IF @type <> '' SET @sql = @sql + ' AND typePoint = ' + CAST(@type AS NVARCHAR(50)) 			
			IF @code1 <> '' SET @sql = @sql + ' AND pointCode1 = ''' + @code1 + ''''
			IF @code2 <> '' SET @sql = @sql + ' AND pointCode2 = ''' + @code2 + ''''
			IF @channel <> '' SET @sql = @sql + ' AND channelCode = ''' + @channel + ''''

			SET @sql = @sql +  ' ) GROUP BY [start], [end], [summer] '

			--PRINT @sql
			EXEC (@sql)

		END
		FETCH NEXT FROM cursorPlan INTO @koef, @area, @type, @code1, @code2, @channel , @inn
	END
	CLOSE cursorPlan
	DEALLOCATE cursorPlan

/*
формат логики
0 accountpoint
1 measuringpoint
2 deliverypoint

3 deliverygroup
4 peretok

area:type:point1:point2:channel

area:type:group1:group2

*/
--	SELECT * FROM #tmp 
	
	SELECT [startGroup] + '00' AS [start]
		, CASE [startGroup]
		  WHEN '23' THEN '0000'
		  ELSE RIGHT( '0'+RTRIM(CAST(CAST([startGroup] AS INT) + 1 AS NCHAR(2))), 2 ) + '00'		
		  END AS [end]	
		, [summer], SUM(SumStatus) AS SumStatus, SUM(Value) AS Value 
	FROM #tmp 
	GROUP BY [startGroup], [summer]
	ORDER BY [startGroup], [summer] DESC

	DROP TABLE #tmp

END
GO
/****** Object:  StoredProcedure [dbo].[m80020_Insert_Area]    Script Date: 09/11/2012 11:24:03 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE   PROCEDURE [dbo].[m80020_Insert_Area]
(
	@inn NVARCHAR(50),
	@name NVARCHAR(250),
	@timezone INT
)
AS
BEGIN
	IF EXISTS (SELECT * FROM m80020_Area WHERE inn = @inn )
	BEGIN
		UPDATE m80020_Area 
		SET [name] = @name, timezone = @timezone
		WHERE inn = @inn
	END
	ELSE
	BEGIN
		INSERT INTO m80020_Area(inn, [name], timezone)
		VALUES (@inn, @name, @timezone)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[m80020_Insert_Channel]    Script Date: 09/11/2012 11:24:03 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE   PROCEDURE [dbo].[m80020_Insert_Channel]
(	
	@typePoint INT,
	@areaINN NVARCHAR(50),
	@pointCode NVARCHAR(50),
	@code NVARCHAR(50) = '',	
	@desc NVARCHAR(250)
)
AS
BEGIN
	IF EXISTS (SELECT * FROM m80020_Channel WHERE typePoint = @typePoint AND code = @code AND areaINN = @areaINN AND pointCode = @pointCode )
	BEGIN
		UPDATE m80020_Channel 
		SET [desc] = @desc
		WHERE typePoint = @typePoint AND code = @code AND areaINN = @areaINN AND pointCode = @pointCode
	END
	ELSE
	BEGIN
		INSERT INTO m80020_Channel(code, areaINN, typePoint, pointCode, [desc])
		VALUES (@code, @areaINN, @typePoint, @pointCode, @desc)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[m80020_Insert_Point]    Script Date: 09/11/2012 11:24:04 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE   PROCEDURE [dbo].[m80020_Insert_Point]
(	
	@typePoint INT,
	@areaINN NVARCHAR(50),
	@code1 NVARCHAR(50) = '',
	@code2 NVARCHAR(50) = '',
	@name NVARCHAR(250)
)
AS
BEGIN
	IF EXISTS (SELECT * FROM m80020_Point WHERE typePoint = @typePoint AND [code1] = @code1 AND [code2] = @code2 AND areaINN = @areaINN )
	BEGIN
		UPDATE m80020_Point 
		SET [name] = @name
		WHERE typePoint = @typePoint AND code1 = @code1 AND code2 = @code2 AND areaINN = @areaINN
	END
	ELSE
	BEGIN
		INSERT INTO m80020_Point(code1, code2, areaINN, typePoint, [name])
		VALUES (@code1, @code2, @areaINN, @typePoint, @name)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[m80020_Parse]    Script Date: 09/11/2012 11:24:04 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE          PROCEDURE [dbo].[m80020_Parse] 
(
	@maket NTEXT,
	@filename NVARCHAR(250),
	@error NVARCHAR(250) = '' OUTPUT 
)
AS
BEGIN

	SET NOCOUNT ON	
		
--	PRINT 'starting parse m80020'
--	PRINT @maket
--	print @filename	

	BEGIN TRANSACTION

	DECLARE @idoc INT

	DECLARE	@inn NVARCHAR(50),
		@name NVARCHAR(250),		
		@timezone INT,
		@areaINN NVARCHAR(50),
		@code1 NVARCHAR(50),
		@code2 NVARCHAR(50),
		@pointCode NVARCHAR(50),
		@desc NVARCHAR(250)

--parse--------------------------

--	PRINT 'prepare XML document'
	EXEC sp_xml_preparedocument @idoc OUTPUT, @maket

-- проверка заголовка макета И имени файла ------

	DECLARE @Hnumber INT,
		@Hday NCHAR(8),
		@Hinn NVARCHAR(50)

	SELECT @Hnumber=[number], @Hday=[day], @Hinn=[inn]
    	FROM OPENXML (@idoc, N'/message')
    	WITH 
	(
		[number] INT 'attribute::number',
		[day] NCHAR(8) 'datetime/day',
		[inn] NVARCHAR(50) 'sender/inn'
	)
	DECLARE @i1 INT, @i2 INT, @i3 INT, @i4 INT	
	SET @i1 = CHARINDEX('_', @filename, 0)
	SET @i2 = CHARINDEX('_', @filename, @i1 + 1)
	SET @i3 = CHARINDEX('_', @filename, @i2 + 1)
	SET @i4 = CHARINDEX('_', @filename, @i3 + 1)
	IF @i4 = 0 SET @i4 = CHARINDEX('.', @filename, @i3 + 1)
	IF @i4 = 0 SET @i4 = LEN(@filename)
	--80020_600004_20080206_820_....xml	
	IF SUBSTRING(@filename, 0, @i1 - 0) <> '80020'
	BEGIN
		SET @error = 'Не верный номер макета, должен быть 80020.'
		ROLLBACK TRANSACTION
		RETURN 1	
	END
	IF SUBSTRING(@filename, @i1 + 1, @i2 - @i1 - 1) <> @Hinn
	BEGIN
		SET @error = 'В названии и в заголовке XML не совпадают ИНН организации'
		ROLLBACK TRANSACTION
		RETURN 1	
	END
	IF SUBSTRING(@filename, @i2 + 1, @i3 - @i2 - 1) <> @Hday
	BEGIN
		SET @error = 'В названии и в заголовке XML не совпала дата макета'
		ROLLBACK TRANSACTION
		RETURN 1	
	END
	IF CAST(SUBSTRING(@filename, @i3 + 1, @i4 - @i3 - 1) AS INT) <> @Hnumber
	BEGIN
		SET @error = 'В названии и в заголовке XML не совпал номер макета'
		ROLLBACK TRANSACTION
		RETURN 1	
	END

	IF EXISTS (SELECT * FROM m80020_IN_Header WHERE [inn] = @Hinn  AND [number] = @Hnumber AND [day] = @Hday )
	BEGIN
		SET @error = 'В базе данных уже присутствуют данные на ИНН ' + @Hinn + ' с номером ' + CAST(@Hnumber AS VARCHAR(50)) + ' и датой ' + @Hday
		ROLLBACK TRANSACTION
		RETURN 1	
	END

-- header ------------------

--	PRINT 'inserting in m80020_IN_Header'
	INSERT m80020_IN_Header([number], [day], [timestamp], [daylightsavingtime], [inn], [name], [comment])
		SELECT [number], [day], [timestamp], [daylightsavingtime], [inn], [name], [comment]
	    	FROM OPENXML (@idoc, N'/message')
	    	WITH 
		(
			[number] INT 'attribute::number',
			[day] NCHAR(8) 'datetime/day',
			[timestamp] NCHAR(14) 'datetime/timestamp',
			[daylightsavingtime] NCHAR(1) 'datetime/daylightsavingtime',
			[inn] NVARCHAR(50) 'sender/inn',
			[name] NVARCHAR(250) 'sender/name',
			[comment] NTEXT 'comment'
		)

	IF @@ROWCOUNT <> 1 
	BEGIN
		SET @error = 'Должен быть один корневой элемент message'
		ROLLBACK TRANSACTION
		RETURN 1	
	END

	DECLARE @headerID INT
	SET @headerID = @@IDENTITY

--area------------------

--	PRINT 'Area'
	DECLARE cursorArea CURSOR FOR
		SELECT [inn], [name], [timezone] 
	    	FROM OPENXML (@idoc, N'/message/area')
	    	WITH 
		(
			[inn] NVARCHAR(50) 'inn',
			[name] NVARCHAR(250) 'name',
			[timezone] INT 'attribute::timezone'
		)
		
	OPEN cursorArea
	FETCH NEXT FROM cursorArea INTO @inn, @name, @timezone
	WHILE (@@fetch_status <> -1)
	BEGIN
		IF (@@fetch_status <> -2)
			EXEC m80020_Insert_Area @inn, @name, @timezone 	
		FETCH NEXT FROM cursorArea INTO @inn, @name, @timezone
	END
	CLOSE cursorArea
	DEALLOCATE cursorArea

--deliverygroup----------------------

--	PRINT 'Deliverygroup'
	DECLARE cursorDeliverygroup CURSOR FOR 
		SELECT [areaINN], [code], [name]
	    	FROM OPENXML (@idoc, N'/message/area/deliverygroup')
	    	WITH 
		(
			[areaINN] NVARCHAR(50) '../inn',
			[code] NVARCHAR(50) 'attribute::code',
			[name] NVARCHAR(250) 'attribute::name'
		)

	OPEN cursorDeliverygroup
	FETCH NEXT FROM cursorDeliverygroup INTO @areaINN, @code1, @name
	WHILE (@@fetch_status <> -1)
	BEGIN
		IF (@@fetch_status <> -2)
			EXEC m80020_Insert_Point 3, @areaINN, @code1, '', @name
		FETCH NEXT FROM cursorDeliverygroup INTO @areaINN, @code1, @name
	END
	CLOSE cursorDeliverygroup
	DEALLOCATE cursorDeliverygroup

--peretok----------------------

--	PRINT 'Peretok'
	DECLARE cursorPeretok CURSOR FOR 
		SELECT [areaINN], [code1], [code2], [name]
	    	FROM OPENXML (@idoc, N'/message/area/peretok')
	    	WITH 
		(
			[areaINN] NVARCHAR(50) '../inn',
			[code1] NVARCHAR(50) 'attribute::codefrom',
			[code2] NVARCHAR(50) 'attribute::codeto',
			[name] NVARCHAR(250) 'attribute::name'
		)

	OPEN cursorPeretok
	FETCH NEXT FROM cursorPeretok INTO @areaINN, @code1, @code2, @name
	WHILE (@@fetch_status <> -1)
	BEGIN
		IF (@@fetch_status <> -2)
			EXEC m80020_Insert_Point 4, @areaINN, @code1, @code2, @name
		FETCH NEXT FROM cursorPeretok INTO @areaINN, @code1, @code2, @name
	END
	CLOSE cursorPeretok
	DEALLOCATE cursorPeretok

--accountpoint----------------------

--	PRINT 'Accountpoint'
	DECLARE cursorAccountpoint CURSOR FOR 
		SELECT [areaINN], [code], [name]
	    	FROM OPENXML (@idoc, N'/message/area/accountpoint')
	    	WITH 
		(
			[areaINN] NVARCHAR(50) '../inn',
			[code] NVARCHAR(50) 'attribute::code',
			[name] NVARCHAR(250) 'attribute::name'
		)

	OPEN cursorAccountpoint
	FETCH NEXT FROM cursorAccountpoint INTO @areaINN, @code1, @name
	WHILE (@@fetch_status <> -1)
	BEGIN
		IF (@@fetch_status <> -2)
			EXEC m80020_Insert_Point 0, @areaINN, @code1, '', @name
		FETCH NEXT FROM cursorAccountpoint INTO @areaINN, @code1, @name
	END
	CLOSE cursorAccountpoint
	DEALLOCATE cursorAccountpoint

--measuringpoint----------------------

--	PRINT 'Measuringpoint'
	DECLARE cursorAccountpoint CURSOR FOR 
		SELECT [areaINN], [code], [name]
	    	FROM OPENXML (@idoc, N'/message/area/measuringpoint')
	    	WITH 
		(
			[areaINN] NVARCHAR(50) '../inn',
			[code] NVARCHAR(50) 'attribute::code',
			[name] NVARCHAR(250) 'attribute::name'
		)

	OPEN cursorAccountpoint
	FETCH NEXT FROM cursorAccountpoint INTO @areaINN, @code1, @name
	WHILE (@@fetch_status <> -1)
	BEGIN
		IF (@@fetch_status <> -2)
			EXEC m80020_Insert_Point 1, @areaINN, @code1, '', @name
		FETCH NEXT FROM cursorAccountpoint INTO @areaINN, @code1, @name
	END
	CLOSE cursorAccountpoint
	DEALLOCATE cursorAccountpoint

--deliverypoint----------------------

--	PRINT 'Deliverypoint'
	DECLARE cursorDeliverypoint CURSOR FOR 
		SELECT [areaINN], [code], [name]
	    	FROM OPENXML (@idoc, N'/message/area/deliverypoint')
	    	WITH 
		(
			[areaINN] NVARCHAR(50) '../inn',
			[code] NVARCHAR(50) 'attribute::code',
			[name] NVARCHAR(250) 'attribute::name'
		)

	OPEN cursorDeliverypoint
	FETCH NEXT FROM cursorDeliverypoint INTO @areaINN, @code1, @name
	WHILE (@@fetch_status <> -1)
	BEGIN
		IF (@@fetch_status <> -2)
			EXEC m80020_Insert_Point 2, @areaINN, @code1, '', @name
		FETCH NEXT FROM cursorDeliverypoint INTO @areaINN, @code1, @name
	END
	CLOSE cursorDeliverypoint
	DEALLOCATE cursorDeliverypoint

--measuringchannel measuringpoint--------

--	PRINT 'measuringchannel measuringpoint'
	DECLARE cursorMeasuringchannel CURSOR FOR 
		SELECT [areaINN], [pointCode], [code], [desc]
	    	FROM OPENXML (@idoc, N'/message/area/measuringpoint/measuringchannel')
	    	WITH 
		(
			[areaINN] NVARCHAR(50) '../../inn',
			[pointCode] NVARCHAR(50) '../attribute::code',
			[code] NVARCHAR(50) 'attribute::code',
			[desc] NVARCHAR(250) 'attribute::desc'
		)

	OPEN cursorMeasuringchannel
	FETCH NEXT FROM cursorMeasuringchannel INTO @areaINN, @pointCode, @code1, @desc
	WHILE (@@fetch_status <> -1)
	BEGIN
		IF (@@fetch_status <> -2)
			EXEC m80020_Insert_Channel 1, @areaINN, @pointCode, @code1, @desc
		FETCH NEXT FROM cursorMeasuringchannel INTO @areaINN, @pointCode, @code1, @desc
	END
	CLOSE cursorMeasuringchannel
	DEALLOCATE cursorMeasuringchannel


--measuringchannel accountpoint--------

--	PRINT 'measuringchannel accountpoint'
	DECLARE cursorMeasuringchannel CURSOR FOR 
		SELECT [areaINN], [pointCode], [code], [desc]
	    	FROM OPENXML (@idoc, N'/message/area/accountpoint/measuringchannel')
	    	WITH 
		(
			[areaINN] NVARCHAR(50) '../../inn',
			[pointCode] NVARCHAR(50) '../attribute::code',
			[code] NVARCHAR(50) 'attribute::code',
			[desc] NVARCHAR(250) 'attribute::desc'
		)

	OPEN cursorMeasuringchannel
	FETCH NEXT FROM cursorMeasuringchannel INTO @areaINN, @pointCode, @code1, @desc
	WHILE (@@fetch_status <> -1)
	BEGIN
		IF (@@fetch_status <> -2)
			EXEC m80020_Insert_Channel 0, @areaINN, @pointCode, @code1, @desc
		FETCH NEXT FROM cursorMeasuringchannel INTO @areaINN, @pointCode, @code1, @desc
	END
	CLOSE cursorMeasuringchannel
	DEALLOCATE cursorMeasuringchannel

--measuringchannel deliverypoint --------

--	PRINT 'measuringchannel deliverypoint'
	DECLARE cursorMeasuringchannel CURSOR FOR 
		SELECT [areaINN], [pointCode], [code], [desc]
	    	FROM OPENXML (@idoc, N'/message/area/deliverypoint/measuringchannel')
	    	WITH 
		(
			[areaINN] NVARCHAR(50) '../../inn',
			[pointCode] NVARCHAR(50) '../attribute::code',
			[code] NVARCHAR(50) 'attribute::code',
			[desc] NVARCHAR(250) 'attribute::desc'
		)

	OPEN cursorMeasuringchannel
	FETCH NEXT FROM cursorMeasuringchannel INTO @areaINN, @pointCode, @code1, @desc
	WHILE (@@fetch_status <> -1)
	BEGIN
		IF (@@fetch_status <> -2)
			EXEC m80020_Insert_Channel 2, @areaINN, @pointCode, @code1, @desc
		FETCH NEXT FROM cursorMeasuringchannel INTO @areaINN, @pointCode, @code1, @desc
	END
	CLOSE cursorMeasuringchannel
	DEALLOCATE cursorMeasuringchannel

--Value deliverygroup-------------

	INSERT INTO m80020_Value ([headerID], [areaINN], [typePoint], [channelCode], [pointCode1], [pointCode2], [start], [end], 
		[summer], [value], [status], [errofmeasuring], [exstendedstatus], [param1], [param2], [param3])
		SELECT @headerID, [areaINN], 3, '', [deliverygroupCode], '', [start], [end], 
			ISNULL([summer],0), [value], ISNULL([status],0), [errofmeasuring], [exstendedstatus], [param1], [param2], [param3]
	    	FROM OPENXML (@idoc, N'/message/area/deliverygroup/period')
	    	WITH 
		(
			[areaINN] NVARCHAR(50) '../../inn',
			[deliverygroupCode] NVARCHAR(50) '../attribute::code',
			[start] NVARCHAR(4) 'attribute::start',
			[end] NVARCHAR(4) 'attribute::end', 
			[summer] INT 'attribute::summer', 
			[value] INT 'value', 
			[status] INT 'value/attribute::status', 
			[errofmeasuring] NVARCHAR(250) 'value/attribute::errofmeasuring', 
			[exstendedstatus] NVARCHAR(250) 'value/attribute::exstendedstatus', 
			[param1] NVARCHAR(250) 'value/attribute::param1',  
			[param2] NVARCHAR(250) 'value/attribute::param2', 
			[param3] NVARCHAR(250) 'value/attribute::param3' 
		)

--Value peretok-------------

	INSERT INTO m80020_Value ([headerID], [areaINN], [typePoint], [channelCode], [pointCode1], [pointCode2], [start], [end], 
		[summer], [value], [status], [errofmeasuring], [exstendedstatus], [param1], [param2], [param3])
		SELECT @headerID, [areaINN], 4, '', [deliverygroupCodefrom], [deliverygroupCodeto], [start], [end], 
			ISNULL([summer],0), [value], ISNULL([status],0), [errofmeasuring], [exstendedstatus], [param1], [param2], [param3]
	    	FROM OPENXML (@idoc, N'/message/area/peretok/period')
	    	WITH 
		(
			[areaINN] NVARCHAR(50) '../../inn',
			[deliverygroupCodefrom] NVARCHAR(50) '../attribute::codefrom',
			[deliverygroupCodeto] NVARCHAR(50) '../attribute::codeto',
			[start] NVARCHAR(4) 'attribute::start',
			[end] NVARCHAR(4) 'attribute::end', 
			[summer] INT 'attribute::summer', 
			[value] INT 'value', 
			[status] INT 'value/attribute::status', 
			[errofmeasuring] NVARCHAR(250) 'value/attribute::errofmeasuring', 
			[exstendedstatus] NVARCHAR(250) 'value/attribute::exstendedstatus', 
			[param1] NVARCHAR(250) 'value/attribute::param1',  
			[param2] NVARCHAR(250) 'value/attribute::param2', 
			[param3] NVARCHAR(250) 'value/attribute::param3' 
		)

--Value measuringpoint-------------

	INSERT INTO m80020_Value ([headerID], [areaINN], [typePoint], [channelCode], [pointCode1], [pointCode2], [start], [end], 
		[summer], [value], [status], [errofmeasuring], [exstendedstatus], [param1], [param2], [param3])
		SELECT @headerID, [areaINN], 1, [measuringchannelCode], [measuringpointCode], '', [start], [end], 
			ISNULL([summer],0), [value], ISNULL([status],0), [errofmeasuring], [exstendedstatus], [param1], [param2], [param3]
	    	FROM OPENXML (@idoc, N'/message/area/measuringpoint/measuringchannel/period')
	    	WITH 
		(
			[areaINN] NVARCHAR(50) '../../../inn',
			[measuringpointCode] NVARCHAR(50) '../../attribute::code',
			[measuringchannelCode] NVARCHAR(50) '../attribute::code',
			[start] NVARCHAR(4) 'attribute::start',
			[end] NVARCHAR(4) 'attribute::end', 
			[summer] INT 'attribute::summer', 
			[value] INT 'value', 
			[status] INT 'value/attribute::status', 
			[errofmeasuring] NVARCHAR(250) 'value/attribute::errofmeasuring', 
			[exstendedstatus] NVARCHAR(250) 'value/attribute::exstendedstatus', 
			[param1] NVARCHAR(250) 'value/attribute::param1',  
			[param2] NVARCHAR(250) 'value/attribute::param2', 
			[param3] NVARCHAR(250) 'value/attribute::param3' 
		)

--Value accountpoint-------------

	INSERT INTO m80020_Value ([headerID], [areaINN], [typePoint], [channelCode], [pointCode1], [pointCode2], [start], [end], 
		[summer], [value], [status], [errofmeasuring], [exstendedstatus], [param1], [param2], [param3])
		SELECT @headerID, [areaINN], 0, [measuringchannelCode], [accountpointCode], '', [start], [end], 
			ISNULL([summer],0), [value], ISNULL([status],0), [errofmeasuring], [exstendedstatus], [param1], [param2], [param3]
	    	FROM OPENXML (@idoc, N'/message/area/accountpoint/measuringchannel/period')
	    	WITH 
		(
			[areaINN] NVARCHAR(50) '../../../inn',
			[accountpointCode] NVARCHAR(50) '../../attribute::code',
			[measuringchannelCode] NVARCHAR(50) '../attribute::code',
			[start] NVARCHAR(4) 'attribute::start',
			[end] NVARCHAR(4) 'attribute::end', 
			[summer] INT 'attribute::summer', 
			[value] INT 'value', 
			[status] INT 'value/attribute::status', 
			[errofmeasuring] NVARCHAR(250) 'value/attribute::errofmeasuring', 
			[exstendedstatus] NVARCHAR(250) 'value/attribute::exstendedstatus', 
			[param1] NVARCHAR(250) 'value/attribute::param1',  
			[param2] NVARCHAR(250) 'value/attribute::param2', 
			[param3] NVARCHAR(250) 'value/attribute::param3' 
		)

--Value deliverypoint-------------

	INSERT INTO m80020_Value ([headerID], [areaINN], [typePoint], [channelCode], [pointCode1], [pointCode2], [start], [end], 
		[summer], [value], [status], [errofmeasuring], [exstendedstatus], [param1], [param2], [param3])
		SELECT @headerID, [areaINN], 2, [measuringchannelCode], [deliverypointCode], '', [start], [end], 
			ISNULL([summer],0), [value], ISNULL([status],0), [errofmeasuring], [exstendedstatus], [param1], [param2], [param3]
	    	FROM OPENXML (@idoc, N'/message/area/deliverypoint/measuringchannel/period')
	    	WITH 
		(
			[areaINN] NVARCHAR(50) '../../../inn',
			[deliverypointCode] NVARCHAR(50) '../../attribute::code',
			[measuringchannelCode] NVARCHAR(50) '../attribute::code',
			[start] NVARCHAR(4) 'attribute::start',
			[end] NVARCHAR(4) 'attribute::end', 
			[summer] INT 'attribute::summer', 
			[value] INT 'value', 
			[status] INT 'value/attribute::status', 
			[errofmeasuring] NVARCHAR(250) 'value/attribute::errofmeasuring', 
			[exstendedstatus] NVARCHAR(250) 'value/attribute::exstendedstatus', 
			[param1] NVARCHAR(250) 'value/attribute::param1',  
			[param2] NVARCHAR(250) 'value/attribute::param2', 
			[param3] NVARCHAR(250) 'value/attribute::param3' 
		)
-----------------------------------


/*
	PRINT 'Value deliverygroup'
	DECLARE cursorValue CURSOR FOR 
		SELECT [areaINN], [deliverygroupCode], [start], [end], [summer], [value], [status], [errofmeasuring], 
			[exstendedstatus], [param1], [param2], [param3]
	    	FROM OPENXML (@idoc, N'/message/area/deliverygroup/period')
	    	WITH 
		(
			[areaINN] NVARCHAR(50) '../../inn',
			[deliverygroupCode] NVARCHAR(50) '../attribute::code',
			[start] NVARCHAR(4) 'attribute::start',
			[end] NVARCHAR(4) 'attribute::end', 
			[summer] NVARCHAR(1) 'attribute::summer', 
			[value] INT 'value', 
			[status] INT 'value/attribute::status', 
			[errofmeasuring] NVARCHAR(250) 'value/attribute::errofmeasuring', 
			[exstendedstatus] NVARCHAR(250) 'value/attribute::exstendedstatus', 
			[param1] NVARCHAR(250) 'value/attribute::param1',  
			[param2] NVARCHAR(250) 'value/attribute::param2', 
			[param3] NVARCHAR(250) 'value/attribute::param3' 
		)
	OPEN cursorValue
	FETCH NEXT FROM cursorValue INTO @code1, @name
	WHILE (@@fetch_status <> -1)
	BEGIN
		IF (@@fetch_status <> -2)
		BEGIN
			INSERT INTO m80020_Value ([headerID], [areaINN], [typePoint], [pointCode1], [pointCode2], [start], [end], 
				[summer], [value], [status], [errofmeasuring], [exstendedstatus], [param1], [param2], [param3])
			VALUES (@headerID, )

			EXEC m80020_Insert_Value 3, @areaINN, @code1, @code2, @name
headerID  typePoint


		END
		FETCH NEXT FROM cursorValue INTO @code1, @name
	END

	CLOSE cursorValue
	DEALLOCATE cursorValue
*/

/*
	IF @error <> ''
	BEGIN
		PRINT 'Rollback transaction, error: ' + @error
		ROLLBACK TRANSACTION
		RETURN 1		
	END
*/

--	PRINT 'remove XML document'
	EXEC sp_xml_removedocument @idoc

--	PRINT 'stop parse m80020'
	COMMIT TRANSACTION

END
GO
