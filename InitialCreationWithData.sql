/****** Object:  Database [HardwareStoreDb]    Script Date: 5/5/2019 11:55:34 PM ******/
CREATE DATABASE [HardwareStoreDb]  (EDITION = 'Standard', SERVICE_OBJECTIVE = 'S0', MAXSIZE = 250 GB) WITH CATALOG_COLLATION = SQL_Latin1_General_CP1_CI_AS;
GO
ALTER DATABASE [HardwareStoreDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HardwareStoreDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HardwareStoreDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HardwareStoreDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HardwareStoreDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [HardwareStoreDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HardwareStoreDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HardwareStoreDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HardwareStoreDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HardwareStoreDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HardwareStoreDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HardwareStoreDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HardwareStoreDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HardwareStoreDb] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [HardwareStoreDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HardwareStoreDb] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [HardwareStoreDb] SET  MULTI_USER 
GO
ALTER DATABASE [HardwareStoreDb] SET ENCRYPTION ON
GO
ALTER DATABASE [HardwareStoreDb] SET QUERY_STORE = ON
GO
ALTER DATABASE [HardwareStoreDb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO)
GO
/****** Object:  Table [dbo].[customer]    Script Date: 5/5/2019 11:55:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [nvarchar](30) NOT NULL,
	[last_name] [nvarchar](30) NOT NULL,
	[phone_number] [nvarchar](20) NOT NULL,
	[default_location_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customer_order]    Script Date: 5/5/2019 11:55:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer_order](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[order_time] [datetime2](7) NULL,
	[location_id] [int] NOT NULL,
	[customer_id] [int] NOT NULL,
	[order_total] [decimal](18, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[inventory]    Script Date: 5/5/2019 11:55:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[inventory](
	[location_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[amount_in_stock] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[location_id] ASC,
	[product_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_item]    Script Date: 5/5/2019 11:55:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_item](
	[order_id] [int] NOT NULL,
	[order_item_number] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity_bought] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC,
	[order_item_number] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products]    Script Date: 5/5/2019 11:55:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[product_name] [nvarchar](20) NOT NULL,
	[product_description] [nvarchar](150) NULL,
	[product_price] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[store_location]    Script Date: 5/5/2019 11:55:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[store_location](
	[location_id] [int] IDENTITY(1,1) NOT NULL,
	[location_name] [nvarchar](20) NOT NULL,
	[location_address] [nvarchar](60) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[location_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[order_item] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[customer]  WITH CHECK ADD  CONSTRAINT [FK_customer_default_location_id] FOREIGN KEY([default_location_id])
REFERENCES [dbo].[store_location] ([location_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[customer] CHECK CONSTRAINT [FK_customer_default_location_id]
GO
ALTER TABLE [dbo].[customer_order]  WITH CHECK ADD  CONSTRAINT [FK_customer_order_customer_id] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([customer_id])
GO
ALTER TABLE [dbo].[customer_order] CHECK CONSTRAINT [FK_customer_order_customer_id]
GO
ALTER TABLE [dbo].[customer_order]  WITH CHECK ADD  CONSTRAINT [FK_customer_order_location_id] FOREIGN KEY([location_id])
REFERENCES [dbo].[store_location] ([location_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[customer_order] CHECK CONSTRAINT [FK_customer_order_location_id]
GO
ALTER TABLE [dbo].[inventory]  WITH CHECK ADD  CONSTRAINT [FK_inventory_location_id] FOREIGN KEY([location_id])
REFERENCES [dbo].[store_location] ([location_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[inventory] CHECK CONSTRAINT [FK_inventory_location_id]
GO
ALTER TABLE [dbo].[inventory]  WITH CHECK ADD  CONSTRAINT [FK_inventory_product_id] FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([product_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[inventory] CHECK CONSTRAINT [FK_inventory_product_id]
GO
ALTER TABLE [dbo].[order_item]  WITH CHECK ADD  CONSTRAINT [FK_order_item_order_id] FOREIGN KEY([order_id])
REFERENCES [dbo].[customer_order] ([order_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[order_item] CHECK CONSTRAINT [FK_order_item_order_id]
GO
ALTER TABLE [dbo].[order_item]  WITH CHECK ADD  CONSTRAINT [FK_order_item_product_id] FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([product_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[order_item] CHECK CONSTRAINT [FK_order_item_product_id]
GO
ALTER DATABASE [HardwareStoreDb] SET  READ_WRITE 
GO
