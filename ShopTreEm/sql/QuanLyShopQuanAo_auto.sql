USE [master]
GO

CREATE DATABASE [QL_ShopQuanAo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QL_ShopQuanAo', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\QL_ShopQuanAo.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QL_ShopQuanAo_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\QL_ShopQuanAo_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QL_ShopQuanAo] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QL_ShopQuanAo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QL_ShopQuanAo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QL_ShopQuanAo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QL_ShopQuanAo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QL_ShopQuanAo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QL_ShopQuanAo] SET ARITHABORT OFF 
GO
ALTER DATABASE [QL_ShopQuanAo] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QL_ShopQuanAo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QL_ShopQuanAo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QL_ShopQuanAo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QL_ShopQuanAo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QL_ShopQuanAo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QL_ShopQuanAo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QL_ShopQuanAo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QL_ShopQuanAo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QL_ShopQuanAo] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QL_ShopQuanAo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QL_ShopQuanAo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QL_ShopQuanAo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QL_ShopQuanAo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QL_ShopQuanAo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QL_ShopQuanAo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QL_ShopQuanAo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QL_ShopQuanAo] SET RECOVERY FULL 
GO
ALTER DATABASE [QL_ShopQuanAo] SET  MULTI_USER 
GO
ALTER DATABASE [QL_ShopQuanAo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QL_ShopQuanAo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QL_ShopQuanAo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QL_ShopQuanAo] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QL_ShopQuanAo] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QL_ShopQuanAo] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QL_ShopQuanAo', N'ON'
GO
ALTER DATABASE [QL_ShopQuanAo] SET QUERY_STORE = OFF
GO
USE [QL_ShopQuanAo]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_update_QuanAo 9, N'Ten sau khi update 1', 'L', 200000, 100, N'Day la ghi chu', 4, NULL, NULL
-- EXEC sp_select_QuanAo_All
-- GO	

CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BanHang](
	[ID_BH] [int] IDENTITY(1,1) NOT NULL,
	[ID_KH] [int] NOT NULL,
	[ID_GD] [nvarchar](50) NULL,
	[NgayBanHang] [datetime] NULL,
	[Discount] [float] NULL,
 CONSTRAINT [PK_BanHang] PRIMARY KEY CLUSTERED 
(
	[ID_BH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietBanHang](
	[ID_CTBH] [int] IDENTITY(1,1) NOT NULL,
	[ID_QA] [int] NOT NULL,
	[ID_BH] [int] NOT NULL,
	[SoLuongSanPham] [int] NOT NULL,
 CONSTRAINT [PK_ChiTietBanHang] PRIMARY KEY CLUSTERED 
(
	[ID_CTBH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HinhQA](
	[ID_HQA] [int] IDENTITY(1,1) NOT NULL,
	[HinhQA] [image] NOT NULL,
	[HinhQAP] [nvarchar](max) NOT NULL,
	[ID_QA] [int] NOT NULL,
 CONSTRAINT [PK_HinhQA] PRIMARY KEY CLUSTERED 
(
	[ID_HQA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[ID_KH] [int] IDENTITY(1,1) NOT NULL,
	[HoTen] [nvarchar](50) NOT NULL,
	[SDT] [nvarchar](50) NOT NULL,
	[DiaChi] [nvarchar](max) NULL,
 CONSTRAINT [PK_KhachHang] PRIMARY KEY CLUSTERED 
(
	[ID_KH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KieuTaiKhoan](
	[ID_KTK] [int] IDENTITY(1,1) NOT NULL,
	[Ten_KTK] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_KieuTaiKhoan] PRIMARY KEY CLUSTERED 
(
	[ID_KTK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiQA](
	[ID_LQA] [int] IDENTITY(1,1) NOT NULL,
	[Ten_LQA] [nvarchar](100) NOT NULL,
	[Is_Alive] [bit] NOT NULL,
 CONSTRAINT [PK_LoaiQA] PRIMARY KEY CLUSTERED 
(
	[ID_LQA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuanAo](
	[ID_QA] [int] IDENTITY(1,1) NOT NULL,
	[Ten_QA] [nvarchar](100) NOT NULL,
	[Size] [char](5) NOT NULL,
	[ID_LQA] [int] NOT NULL,
	[GiaBan] [float] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[GhiChu] [nvarchar](max) NULL,
	[Is_Alive] [bit] NOT NULL,
 CONSTRAINT [PK_QuanAo] PRIMARY KEY CLUSTERED 
(
	[ID_QA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuanTriVien](
	[ID_QTV] [int] IDENTITY(1,1) NOT NULL,
	[TenDangNhap] [nvarchar](50) NOT NULL,
	[MatKhau] [nvarchar](50) NOT NULL,
	[ID_KTK] [int] NOT NULL,
 CONSTRAINT [PK_QuanTriVien] PRIMARY KEY CLUSTERED 
(
	[ID_QTV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BanHang] ON 

INSERT [dbo].[BanHang] ([ID_BH], [ID_KH], [ID_GD], [NgayBanHang], [Discount]) VALUES (1, 1, N'202001121054', CAST(N'2020-12-11T21:10:40.470' AS DateTime), 30)
INSERT [dbo].[BanHang] ([ID_BH], [ID_KH], [ID_GD], [NgayBanHang], [Discount]) VALUES (2, 2, N'202002121055', CAST(N'2020-12-11T21:10:40.470' AS DateTime), 50)
INSERT [dbo].[BanHang] ([ID_BH], [ID_KH], [ID_GD], [NgayBanHang], [Discount]) VALUES (3, 3, N'202003122054', CAST(N'2020-12-11T21:10:40.470' AS DateTime), 10)
SET IDENTITY_INSERT [dbo].[BanHang] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietBanHang] ON 

INSERT [dbo].[ChiTietBanHang] ([ID_CTBH], [ID_QA], [ID_BH], [SoLuongSanPham]) VALUES (1, 1, 1, 2)
INSERT [dbo].[ChiTietBanHang] ([ID_CTBH], [ID_QA], [ID_BH], [SoLuongSanPham]) VALUES (2, 2, 1, 2)
INSERT [dbo].[ChiTietBanHang] ([ID_CTBH], [ID_QA], [ID_BH], [SoLuongSanPham]) VALUES (3, 3, 1, 1)
INSERT [dbo].[ChiTietBanHang] ([ID_CTBH], [ID_QA], [ID_BH], [SoLuongSanPham]) VALUES (4, 4, 2, 1)
INSERT [dbo].[ChiTietBanHang] ([ID_CTBH], [ID_QA], [ID_BH], [SoLuongSanPham]) VALUES (5, 5, 2, 2)
INSERT [dbo].[ChiTietBanHang] ([ID_CTBH], [ID_QA], [ID_BH], [SoLuongSanPham]) VALUES (6, 6, 1, 3)
INSERT [dbo].[ChiTietBanHang] ([ID_CTBH], [ID_QA], [ID_BH], [SoLuongSanPham]) VALUES (7, 7, 3, 5)
INSERT [dbo].[ChiTietBanHang] ([ID_CTBH], [ID_QA], [ID_BH], [SoLuongSanPham]) VALUES (8, 8, 3, 1)
SET IDENTITY_INSERT [dbo].[ChiTietBanHang] OFF
GO
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

INSERT [dbo].[KhachHang] ([ID_KH], [HoTen], [SDT], [DiaChi]) VALUES (1, N'Dương Văn Tứ', N'0123456789', N'Đà Lạt')
INSERT [dbo].[KhachHang] ([ID_KH], [HoTen], [SDT], [DiaChi]) VALUES (2, N'Mai Thanh Lâm', N'1123456789', N'Đà Lạt')
INSERT [dbo].[KhachHang] ([ID_KH], [HoTen], [SDT], [DiaChi]) VALUES (3, N'Tôn Thất Nhật Minh', N'2123456789', N'Đà Lạt')
INSERT [dbo].[KhachHang] ([ID_KH], [HoTen], [SDT], [DiaChi]) VALUES (4, N'Hoàng Minh Đức', N'3123456789', N'Đà Lạt')
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
GO
SET IDENTITY_INSERT [dbo].[KieuTaiKhoan] ON 

INSERT [dbo].[KieuTaiKhoan] ([ID_KTK], [Ten_KTK]) VALUES (1, N'Quản trị viên')
INSERT [dbo].[KieuTaiKhoan] ([ID_KTK], [Ten_KTK]) VALUES (2, N'Nhân viên')
SET IDENTITY_INSERT [dbo].[KieuTaiKhoan] OFF
GO
SET IDENTITY_INSERT [dbo].[LoaiQA] ON 

INSERT [dbo].[LoaiQA] ([ID_LQA], [Ten_LQA], [Is_Alive]) VALUES (1, N'Quần jean', 1)
INSERT [dbo].[LoaiQA] ([ID_LQA], [Ten_LQA], [Is_Alive]) VALUES (2, N'Áo thun', 1)
INSERT [dbo].[LoaiQA] ([ID_LQA], [Ten_LQA], [Is_Alive]) VALUES (3, N'Váy', 1)
INSERT [dbo].[LoaiQA] ([ID_LQA], [Ten_LQA], [Is_Alive]) VALUES (4, N'Áo len', 1)
SET IDENTITY_INSERT [dbo].[LoaiQA] OFF
GO
SET IDENTITY_INSERT [dbo].[QuanAo] ON 

INSERT [dbo].[QuanAo] ([ID_QA], [Ten_QA], [Size], [ID_LQA], [GiaBan], [SoLuong], [GhiChu], [Is_Alive]) VALUES (1, N'Quần jean ngắn', N'M    ', 1, 100000, 100, N'Quần jean hấp dẫn cho ngày hè năng động', 1)
INSERT [dbo].[QuanAo] ([ID_QA], [Ten_QA], [Size], [ID_LQA], [GiaBan], [SoLuong], [GhiChu], [Is_Alive]) VALUES (2, N'Quần jean dài', N'M    ', 1, 120000, 100, N'Quần jean hấp dẫn cho ngày đông buốt giá', 1)
INSERT [dbo].[QuanAo] ([ID_QA], [Ten_QA], [Size], [ID_LQA], [GiaBan], [SoLuong], [GhiChu], [Is_Alive]) VALUES (3, N'Áo thun hiệu con bò cười', N'M    ', 2, 50000, 50, N'Áo thun con bò', 1)
INSERT [dbo].[QuanAo] ([ID_QA], [Ten_QA], [Size], [ID_LQA], [GiaBan], [SoLuong], [GhiChu], [Is_Alive]) VALUES (4, N'Áo thun Doremon', N'M    ', 2, 50000, 100, N'Áo thun doremon', 1)
INSERT [dbo].[QuanAo] ([ID_QA], [Ten_QA], [Size], [ID_LQA], [GiaBan], [SoLuong], [GhiChu], [Is_Alive]) VALUES (5, N'Váy Doremon', N'M    ', 3, 50000, 70, N'Váy doremon', 1)
INSERT [dbo].[QuanAo] ([ID_QA], [Ten_QA], [Size], [ID_LQA], [GiaBan], [SoLuong], [GhiChu], [Is_Alive]) VALUES (6, N'Váy dài', N'M    ', 3, 150000, 70, N'Váy dài siêu cấp', 1)
INSERT [dbo].[QuanAo] ([ID_QA], [Ten_QA], [Size], [ID_LQA], [GiaBan], [SoLuong], [GhiChu], [Is_Alive]) VALUES (7, N'Áo len mỏng', N'M    ', 4, 200000, 70, N'Áo len mát mẻ', 1)
INSERT [dbo].[QuanAo] ([ID_QA], [Ten_QA], [Size], [ID_LQA], [GiaBan], [SoLuong], [GhiChu], [Is_Alive]) VALUES (8, N'Áo len dày', N'M    ', 4, 300000, 70, N'Áo len ấm áp', 1)
INSERT [dbo].[QuanAo] ([ID_QA], [Ten_QA], [Size], [ID_LQA], [GiaBan], [SoLuong], [GhiChu], [Is_Alive]) VALUES (9, N'Quần jean ngắn MOI MOI', N'M    ', 1, 100000, 100, N'Quần jean hấp dẫn cho ngày hè năng động', 1)
SET IDENTITY_INSERT [dbo].[QuanAo] OFF
GO
SET IDENTITY_INSERT [dbo].[QuanTriVien] ON 

INSERT [dbo].[QuanTriVien] ([ID_QTV], [TenDangNhap], [MatKhau], [ID_KTK]) VALUES (1, N'DUONGVANTU', N'123', 1)
INSERT [dbo].[QuanTriVien] ([ID_QTV], [TenDangNhap], [MatKhau], [ID_KTK]) VALUES (2, N'MAITHANHLAM', N'123', 1)
INSERT [dbo].[QuanTriVien] ([ID_QTV], [TenDangNhap], [MatKhau], [ID_KTK]) VALUES (3, N'TONTHATNHATMINH', N'123', 1)
INSERT [dbo].[QuanTriVien] ([ID_QTV], [TenDangNhap], [MatKhau], [ID_KTK]) VALUES (4, N'HOANGMINHDUC', N'123', 1)
INSERT [dbo].[QuanTriVien] ([ID_QTV], [TenDangNhap], [MatKhau], [ID_KTK]) VALUES (5, N'NHANVIEN', N'123', 2)
SET IDENTITY_INSERT [dbo].[QuanTriVien] OFF
GO
ALTER TABLE [dbo].[BanHang] ADD  DEFAULT (NULL) FOR [ID_GD]
GO
ALTER TABLE [dbo].[BanHang] ADD  DEFAULT (getdate()) FOR [NgayBanHang]
GO
ALTER TABLE [dbo].[BanHang] ADD  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[LoaiQA] ADD  DEFAULT ((1)) FOR [Is_Alive]
GO
ALTER TABLE [dbo].[QuanAo] ADD  DEFAULT ((1)) FOR [Is_Alive]
GO
ALTER TABLE [dbo].[BanHang]  WITH CHECK ADD  CONSTRAINT [FK_KhachHang_BanHang] FOREIGN KEY([ID_KH])
REFERENCES [dbo].[KhachHang] ([ID_KH])
GO
ALTER TABLE [dbo].[BanHang] CHECK CONSTRAINT [FK_KhachHang_BanHang]
GO
ALTER TABLE [dbo].[ChiTietBanHang]  WITH CHECK ADD  CONSTRAINT [FK_BanHang_ChiTietBanHang] FOREIGN KEY([ID_BH])
REFERENCES [dbo].[BanHang] ([ID_BH])
GO
ALTER TABLE [dbo].[ChiTietBanHang] CHECK CONSTRAINT [FK_BanHang_ChiTietBanHang]
GO
ALTER TABLE [dbo].[ChiTietBanHang]  WITH CHECK ADD  CONSTRAINT [FK_QuanAo_ChiTietBanHang] FOREIGN KEY([ID_QA])
REFERENCES [dbo].[QuanAo] ([ID_QA])
GO
ALTER TABLE [dbo].[ChiTietBanHang] CHECK CONSTRAINT [FK_QuanAo_ChiTietBanHang]
GO
ALTER TABLE [dbo].[HinhQA]  WITH CHECK ADD  CONSTRAINT [FK_QuanAo_HinhQuanAo] FOREIGN KEY([ID_QA])
REFERENCES [dbo].[QuanAo] ([ID_QA])
GO
ALTER TABLE [dbo].[HinhQA] CHECK CONSTRAINT [FK_QuanAo_HinhQuanAo]
GO
ALTER TABLE [dbo].[QuanAo]  WITH CHECK ADD  CONSTRAINT [FK_LoaiQA_QuanAo] FOREIGN KEY([ID_LQA])
REFERENCES [dbo].[LoaiQA] ([ID_LQA])
GO
ALTER TABLE [dbo].[QuanAo] CHECK CONSTRAINT [FK_LoaiQA_QuanAo]
GO
ALTER TABLE [dbo].[QuanTriVien]  WITH CHECK ADD  CONSTRAINT [FK_KieuTaiKhoan_QuanTriVien] FOREIGN KEY([ID_KTK])
REFERENCES [dbo].[KieuTaiKhoan] ([ID_KTK])
GO
ALTER TABLE [dbo].[QuanTriVien] CHECK CONSTRAINT [FK_KieuTaiKhoan_QuanTriVien]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_ThanhToanBanHang 8, '20201120', 10

-- SELECT * FROM BanHang
-- GO

-- HỦY ĐƠN HÀNG
CREATE PROCEDURE [dbo].[sp_delete_BanHang]
@ID_BH INT
AS
BEGIN
	IF (EXISTS (SELECT * FROM BanHang WHERE ID_BH = @ID_BH AND ID_GD IS NOT NULL))
		RETURN

	DELETE ChiTietBanHang
	WHERE ID_BH = @ID_BH

	DELETE BanHang
	WHERE ID_BH = @ID_BH
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_SoLuongSanPham_by_ID_LQA 1
-- GO

CREATE PROCEDURE [dbo].[sp_delete_LoaiQA]
@ID_LQA INT
AS
BEGIN
	UPDATE LoaiQA
	SET
		Is_Alive = 0
	WHERE ID_LQA = @ID_LQA
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_search_QuanAo_GiaCa 'ao',100000,250000

CREATE PROCEDURE [dbo].[sp_delete_QuanAo]
@ID_QA INT
AS
BEGIN
	UPDATE QuanAo
	SET
		Is_Alive = 0
	WHERE ID_QA = @ID_QA
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_insert_QuanTriVien 1, N'NHANVIEN2', N'222'


CREATE PROC [dbo].[sp_delete_QuanTriVien]
@id_qtv INT
AS
BEGIN
	DELETE FROM QuanTriVien
	WHERE ID_QTV = @id_qtv
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_BanHang_by_ID 1
-- GO

CREATE PROCEDURE [dbo].[sp_insert_BanHang]
@ID_GD NVARCHAR(50),
@Discount FLOAT,
@HoTen NVARCHAR(50),
@SDT NVARCHAR(50),
@DiaChi NVARCHAR(MAX)
AS
BEGIN
	IF (EXISTS (SELECT * FROM BanHang WHERE BanHang.ID_GD = @ID_GD))
		RETURN

	DECLARE @ID_KH INT
	IF (NOT EXISTS (SELECT * FROM KhachHang WHERE KhachHang.SDT = @SDT))
	BEGIN
		INSERT KhachHang(HoTen, SDT, DiaChi)
		VALUES (@HoTen, @SDT, @DiaChi)

		SELECT @ID_KH = MAX(ID_KH) FROM KhachHang
	END
	ELSE
	BEGIN
		SELECT @ID_KH = ID_KH FROM KhachHang WHERE KhachHang.SDT = @SDT
	END

	INSERT BanHang(ID_GD, ID_KH, NgayBanHang, Discount)
	VALUES (@ID_GD, @ID_KH, GETDATE(), @Discount)

	DECLARE @ID INT;
	SELECT @ID = MAX(ID_BH) FROM BanHang;

	SELECT * FROM BanHang WHERE ID_BH = @ID;
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SELECT * FROM BanHang

-- EXEC sp_select_BanHang_ChuaThanhToan_By_KhachHang 2
-- GO

-- TẠO ĐƠN HÀNG MỚI, CHƯA ĐƯỢC THANH TOÁN
CREATE PROCEDURE [dbo].[sp_insert_BanHang_ChuaThanhToan]
@HoTen NVARCHAR(50),
@SDT NVARCHAR(50),
@DiaChi NVARCHAR(MAX)
AS
BEGIN
	DECLARE @ID_KH INT
	IF (NOT EXISTS (SELECT * FROM KhachHang WHERE KhachHang.SDT = @SDT))
	BEGIN
		INSERT KhachHang(HoTen, SDT, DiaChi)
		VALUES (@HoTen, @SDT, @DiaChi)

		SELECT @ID_KH = MAX(ID_KH) FROM KhachHang
	END
	ELSE
	BEGIN
		SELECT @ID_KH = ID_KH FROM KhachHang WHERE KhachHang.SDT = @SDT
	END

	INSERT BanHang(ID_KH, NgayBanHang)
	VALUES (@ID_KH, GETDATE())
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[sp_insert_ChiTietBanHang]
@ID_QA INT,
@ID_BH INT,
@SoLuongSanPham INT
AS
BEGIN
	IF (NOT EXISTS (SELECT * FROM QuanAo WHERE QuanAo.ID_QA = @ID_QA OR QuanAo.Is_Alive = 1))
		RETURN

	IF (NOT EXISTS (SELECT * FROM BanHang WHERE BanHang.ID_BH = @ID_BH))
		RETURN

	INSERT ChiTietBanHang(ID_BH, ID_QA, SoLuongSanPham)
	VALUES (@ID_BH, @ID_QA, @SoLuongSanPham)

	DECLARE @SLtonKho INT;
	SELECT @SLtonKho = SoLuong FROM QuanAo WHERE ID_QA = @ID_QA

	DECLARE @SLMoi INT = @SLtonKho - @SoLuongSanPham;
	UPDATE QuanAo
	SET SoLuong = @SLMoi
	WHERE ID_QA = @ID_QA
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_LoaiQuanAo_by_Name 'ao'
-- GO

CREATE PROCEDURE [dbo].[sp_insert_LoaiQuanAo]
@Ten_LQA NVARCHAR(30)
AS
BEGIN
	IF (NOT EXISTS (SELECT * FROM dbo.LoaiQA WHERE Ten_LQA = @Ten_LQA))
		INSERT INTO dbo.LoaiQA (Ten_LQA) VALUES (@Ten_LQA)
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_QuanAo_by_ID_LQA 1
-- GO

CREATE PROCEDURE [dbo].[sp_insert_QuanAo]
@Ten_QA NVARCHAR(100),
@Size CHAR(5),
@GiaBan FLOAT,
@SoLuong INT,
@GhiChu NVARCHAR(MAX),
@ID_LQA INT,
@HinhQA IMAGE NULL,
@HinhQAP NVARCHAR(MAX) NULL
AS
BEGIN
	IF (@ID_LQA IS NULL OR @ID_LQA = '')
		RETURN

	IF (NOT EXISTS(SELECT * FROM LoaiQA WHERE LoaiQA.ID_LQA = @ID_LQA))
		RETURN

	IF (EXISTS (SELECT * FROM QuanAo WHERE QuanAo.Ten_QA = @Ten_QA))
		RETURN

	INSERT QuanAo(Ten_QA, ID_LQA, Size, SoLuong, GiaBan, GhiChu)
	VALUES (@Ten_QA, @ID_LQA, @Size, @SoLuong, @GiaBan, @GhiChu)

	DECLARE @ID_MAX INT
	SELECT @ID_MAX = MAX(ID_QA) FROM QuanAo

	IF (@HinhQA IS NULL OR @HinhQAP IS NULL)
		RETURN
	
	INSERT HinhQA(ID_QA, HinhQA, HinhQAP)
	VALUES (@ID_MAX, @HinhQA, @HinhQAP)
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_KieuTaiKhoan


CREATE PROC [dbo].[sp_insert_QuanTriVien]
@ID_KTK INT, @TenDangNhap NVARCHAR(50), @MatKhau NVARCHAR(50)
AS
BEGIN
	IF(EXISTS(SELECT * FROM QuanTriVien WHERE TenDangNhap=@TenDangNhap))
		RETURN

	INSERT QuanTriVien(ID_KTK,TenDangNhap,MatKhau)
	VALUES (@ID_KTK, @TenDangNhap, @MatKhau)
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_DangNhap N'THIHA', N'123'
-- EXEC sp_select_DangNhap N'THIHA', N'345'
-- EXEC sp_select_DangNhap N'NHANVIEN', N'111'

CREATE PROCEDURE [dbo].[sp_select_Account_By_UserName]
@username NVARCHAR(100)
AS
BEGIN
	SELECT ID_QTV,TenDangNhap, MatKhau, Ten_KTK FROM QuanTriVien
	JOIN KieuTaiKhoan ON QuanTriVien.ID_KTK = KieuTaiKhoan.ID_KTK
	WHERE @username = TenDangNhap
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_select_BanHang_All]
AS
	BEGIN		
		SELECT ID_BH, ID_GD, HoTen, SDT, NgayBanHang, Discount
		FROM dbo.BanHang
		JOIN KhachHang ON BanHang.ID_KH = KhachHang.ID_KH
		WHERE ID_GD IS NOT NULL
	END	
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_BanHang_All
-- GO

CREATE PROCEDURE [dbo].[sp_select_BanHang_by_ID]
@ID_BH INT
AS
	BEGIN
		SELECT  ID_BH, ID_GD, NgayBanHang, Discount, HoTen, SDT
		FROM dbo.BanHang
		JOIN KhachHang ON BanHang.ID_KH = KhachHang.ID_KH
		WHERE BanHang.ID_BH = @ID_BH AND ID_GD IS NOT NULL
	END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_banHang_FromDateToDate '20201201', '20201231'
-- GO

-- tinh so luong don hang cua 1 khach hang
CREATE PROCEDURE [dbo].[sp_select_BanHang_By_KhacHang_ID]
@ID_KH INT
AS
BEGIN
	SELECT COUNT(*) FROM BanHang WHERE ID_KH = @ID_KH AND ID_GD IS NOT NULL
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_BanHang_By_KhacHang_ID 2
-- GO

CREATE PROCEDURE [dbo].[sp_select_BanHang_By_KhachHang_SDT]
@SDT NVARCHAR(100) 
AS
BEGIN
	SELECT COUNT(*) FROM BanHang
	JOIN KhachHang ON KhachHang.ID_KH = BanHang.ID_KH
	WHERE SDT = @SDT AND ID_GD IS NOT NULL
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SELECT * FROM ChiTietBanHang
-- SELECT * FROM KhachHang

-- EXEC sp_insert_BanHang '202002120105', 10, 'Nguyen Trong Hieu', '0374408253', 'Da Lat'
-- EXEC sp_insert_BanHang '202002120108', 10, N'Phạm Thị Hồng Nhung', '0374408256', 'Da Lat'
-- GO

-- BÁN HÀNG --
-- MỖI KHÁCH HÀNG CÓ DUY NHẤT 1 ĐƠN HÀNG CHƯA ĐƯỢC THANH TOÁN

-- LẤY ĐƠN HÀNG CHƯA ĐƯỢC THANH TOÁN CỦA 1 KHÁCH HÀNG
CREATE PROCEDURE [dbo].[sp_select_BanHang_ChuaThanhToan_By_KhachHang]
@ID_KH INT
AS
BEGIN
	SELECT ID_BH
	FROM BanHang
	WHERE ID_KH = @ID_KH AND ID_GD IS NULL
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- them proc tim don hang theo ngay
CREATE PROC [dbo].[sp_select_banHang_FromDateToDate]
@fromDate DATE, @toDate DATE
AS
BEGIN
	SELECT ID_BH, ID_GD, HoTen, SDT, NgayBanHang, Discount FROM BanHang
	JOIN KhachHang ON BanHang.ID_KH = KhachHang.ID_KH
	WHERE 
		ID_GD IS NOT NULL AND 
		@fromDate <= NgayBanHang AND NgayBanHang <= @toDate
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_select_cacsanphamkhongbanduoc]
AS
	BEGIN
	SELECT ID_QA, Ten_QA
	FROM QuanAo
	WHERE ID_QA NOT IN (
		SELECT DISTINCT ID_QA FROM ChiTietBanHang
	)
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SELECT * FROM KhachHang

-- INSERT BanHang(ID_KH, NgayBanHang, Discount)
-- VALUES (3, '20200212', 10)

-- SELECT * FROM BanHang

-- EXEC sp_insert_ChiTietBanHang 1, 5, 1
-- EXEC sp_insert_ChiTietBanHang 1, 5, 1
-- EXEC sp_insert_ChiTietBanHang 3, 5, 1
-- EXEC sp_insert_ChiTietBanHang 1, 5, -1

-- EXEC sp_select_BanHang_All

-- EXEC sp_select_ChiTietBanHang 5

-- SELECT * FROM ChiTietBanHang

-- SELECT * FROM BanHang
-- SELECT * FROM ChiTietBanHang
-- GO

-- select * from ChiTietBanHang
-- go

CREATE PROCEDURE [dbo].[sp_select_ChiTietBanHang]
@ID_BH INT
AS
BEGIN
	SELECT ID_CTBH, QuanAo.ID_QA, Ten_QA, GiaBan, SoLuongSanPham
	FROM ChiTietBanHang 
	INNER JOIN QuanAo ON QuanAo.ID_QA = ChiTietBanHang.ID_QA
	WHERE ID_BH = @ID_BH
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_select_DangNhap]
@TenDangNhap NVARCHAR(50),
@MatKhau NVARCHAR(50)
AS
BEGIN
	SELECT ID_QTV,TenDangNhap, MatKhau, Ten_KTK FROM QuanTriVien
	JOIN KieuTaiKhoan ON QuanTriVien.ID_KTK = KieuTaiKhoan.ID_KTK
	WHERE TenDangNhap = @TenDangNhap AND MatKhau = @MatKhau
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_select_Doanhthubanhangcuatungthangtrongnam]
(
	@Year int
)
as 
	begin
		SELECT MONTH(BanHang.NgayBanHang) AS THANG, SUM(SoLuongSanPham * GiaBan) AS DOANHTHU
		FROM  ChiTietBanHang join BanHang
		on BanHang.ID_BH = ChiTietBanHang.ID_BH
		join  QuanAo on
		ChiTietBanHang.ID_QA = QuanAo.ID_QA
		WHERE YEAR(NgayBanHang) = @Year
		GROUP BY MONTH(NgayBanHang)
	end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_Account_By_UserName N'TRONGHIEU'
-- GO

-- EXEC sp_select_DangNhapAdmin N'TRONGHIEU', N'123'


CREATE PROCEDURE [dbo].[sp_select_GetAccount]
AS
BEGIN
	SELECT ID_QTV, TenDangNhap, MatKhau, Ten_KTK
	FROM QuanTriVien
	JOIN KieuTaiKhoan ON QuanTriVien.ID_KTK = KieuTaiKhoan.ID_KTK
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_select_HinhSanPham_By_ID]
@ID_HQA INT
AS
BEGIN
	SELECT *
	FROM HinhQA
	WHERE ID_HQA = @ID_HQA
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_HinhSanPham_By_ID 1
-- GO

CREATE PROCEDURE [dbo].[sp_select_HinhSanPham_By_ID_QA]
@ID_QA INT
AS
BEGIN
	SELECT TOP 1 * FROM HinhQA WHERE ID_QA = @ID_QA
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--them proc xem khach hang
CREATE PROCEDURE [dbo].[sp_select_KhachHang]
AS SELECT * FROM KhachHang
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_KhachHang
-- GO

CREATE PROCEDURE [dbo].[sp_select_KhachHang_By_ID]
@id INT
AS
BEGIN
	SELECT * FROM KhachHang WHERE ID_KH = @id
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_select_KhachHang_By_KeyWord]
@TieuChuanTim NVARCHAR(100)
AS
BEGIN
	SELECT *
	FROM KhachHang
	WHERE 
		dbo.fuConvertToUnsign1(HoTen) LIKE '%' + dbo.fuConvertToUnsign1(@TieuChuanTim) + '%' OR
		SDT LIKE '%' + @TieuChuanTim + '%'
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_GetAccount


CREATE PROCEDURE [dbo].[sp_select_KieuTaiKhoan]
AS
BEGIN
	SELECT * FROM KieuTaiKhoan
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_select_LoaiQuanAo_All]
AS
	BEGIN
		SELECT * FROM dbo.LoaiQA
		WHERE Is_Alive = 1
	END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_LoaiQuanAo_All
-- GO

CREATE PROCEDURE [dbo].[sp_select_LoaiQuanAo_by_ID]
@ID_LQA INT
AS
	BEGIN
		SELECT * FROM dbo.LoaiQA 
		WHERE [ID_LQA] = @ID_LQA AND Is_Alive = 1
	END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_LoaiQuanAo_by_ID 1
-- GO

CREATE PROCEDURE [dbo].[sp_select_LoaiQuanAo_by_Name]
@Name NVARCHAR(200)
AS
BEGIN
	SELECT * FROM LoaiQA
	WHERE dbo.fuConvertToUnsign1(Ten_LQA) LIKE '%' + dbo.fuConvertToUnsign1(@Name) + '%' AND
		Is_Alive = 1
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SELECT * FROM LoaiQA

-- EXEC sp_update_LoaiQuanAo 9, N'Áo sơ mi'
-- GO

-- EXEC sp_select_LoaiQuanAo_by_ID 1
-- GO

CREATE PROCEDURE [dbo].[sp_select_Master_LoaiQA]
AS
BEGIN
	SELECT LoaiQA.ID_LQA, COUNT(QuanAo.ID_LQA)  AS SoLuongSanPham, Ten_LQA
	FROM QuanAo JOIN LoaiQA ON QuanAo.ID_LQA = LoaiQA.ID_LQA
	WHERE QuanAo.ID_LQA = LoaiQA.ID_LQA
	GROUP BY LoaiQA.ID_LQA,Ten_LQA
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_select_QuanAo_All]
AS
BEGIN
	SELECT 
		ID_QA, 
		Ten_QA, 
		Size, 
		GiaBan, 
		SoLuong, 
        CASE 
            WHEN LEN(GhiChu) > 150 THEN SUBSTRING(GhiChu, 1, 150) + ' ...'      
			ELSE GhiChu      
		END AS [GhiChu], 
		LoaiQA.ID_LQA, 
		Ten_LQA
	FROM QuanAo
	JOIN LoaiQA ON QuanAo.ID_LQA = LoaiQA.ID_LQA
	WHERE QuanAo.Is_Alive = 1 AND LoaiQA.Is_Alive = 1
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_QuanAo_All
-- GO

CREATE PROCEDURE [dbo].[sp_select_QuanAo_by_ID]
@ID_QA INT
AS
BEGIN
	SELECT 
		ID_QA, 
		Ten_QA, 
		Size, 
		GiaBan, 
		SoLuong, 
        CASE 
            WHEN LEN(GhiChu) > 150 THEN SUBSTRING(GhiChu, 1, 150) + ' ...'     
			ELSE GhiChu          
		END AS [GhiChu], 
		LoaiQA.ID_LQA, 
		Ten_LQA
	FROM QuanAo
	JOIN LoaiQA ON QuanAo.ID_LQA = LoaiQA.ID_LQA
	WHERE QuanAo.ID_QA = @ID_QA AND QuanAo.Is_Alive = 1 AND LoaiQA.Is_Alive = 1
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_QuanAo_by_ID 1
-- GO

CREATE PROCEDURE [dbo].[sp_select_QuanAo_by_ID_LQA]
@ID_LQA INT
AS
BEGIN
	SELECT 
		ID_QA, 
		Ten_QA, 
		Size, 
		GiaBan, 
		SoLuong, 
        CASE 
            WHEN LEN(GhiChu) > 150 THEN SUBSTRING(GhiChu, 1, 150) + ' ...'      
			ELSE GhiChu         
		END AS [GhiChu], 
		LoaiQA.ID_LQA, 
		Ten_LQA
	FROM QuanAo
	JOIN LoaiQA ON QuanAo.ID_LQA = LoaiQA.ID_LQA
	WHERE LoaiQA.ID_LQA = @ID_LQA AND QuanAo.Is_Alive = 1 AND LoaiQA.Is_Alive = 1
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_select_QuanAo_By_Keyword]
@TieuChuanTim NVARCHAR(255)
AS
BEGIN
	SELECT 
		ID_QA, 
		Ten_QA, 
		Size, 
		GiaBan, 
		SoLuong, 
        CASE 
            WHEN LEN(GhiChu) > 150 THEN SUBSTRING(GhiChu, 1, 150) + ' ...'      
			ELSE GhiChu         
		END AS [GhiChu], 
		LoaiQA.ID_LQA, 
		Ten_LQA
	FROM QuanAo
	JOIN LoaiQA ON QuanAo.ID_LQA = LoaiQA.ID_LQA
	WHERE
		QuanAo.Is_Alive = 1 AND LoaiQA.Is_Alive = 1 AND (
			dbo.fuConvertToUnsign1(Ten_QA) LIKE '%' + dbo.fuConvertToUnsign1(@TieuChuanTim) + '%' OR
			QuanAo.ID_QA LIKE '%' + @TieuChuanTim + '%'
		)
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_select_QuanAo_By_Name]
@Name NVARCHAR(100)
AS
BEGIN
	SELECT 
		ID_QA, 
		Ten_QA, 
		Size, 
		GiaBan, 
		SoLuong, 
        CASE 
            WHEN LEN(GhiChu) > 150 THEN SUBSTRING(GhiChu, 1, 150) + ' ...'        
			ELSE GhiChu       
		END AS [GhiChu], 
		LoaiQA.ID_LQA, 
		Ten_LQA
	FROM QuanAo
	JOIN LoaiQA ON QuanAo.ID_LQA = LoaiQA.ID_LQA
	WHERE QuanAo.Is_Alive = 1 AND LoaiQA.Is_Alive = 1 AND Ten_QA = @Name
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_QuanAo_By_Keyword N'vay'
-- GO

CREATE PROCEDURE [dbo].[sp_select_QuanAo_By_Price]
@GiaBanThap FLOAT, 
@GiaBanCao FLOAT
AS
BEGIN
	SELECT 
		ID_QA, 
		Ten_QA, 
		Size, 
		GiaBan, 
		SoLuong, 
        CASE 
            WHEN LEN(GhiChu) > 150 THEN SUBSTRING(GhiChu, 1, 150) + ' ...'        
			ELSE GhiChu       
		END AS [GhiChu], 
		LoaiQA.ID_LQA, 
		Ten_LQA
	FROM QuanAo
	JOIN LoaiQA ON QuanAo.ID_LQA = LoaiQA.ID_LQA
	WHERE QuanAo.Is_Alive = 1 AND LoaiQA.Is_Alive = 1 AND (@GiaBanThap <= GiaBan AND GiaBan <= @GiaBanCao)
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_select_sanphambanchaynhat]
as
	begin
		Select Top 5 Ten_QA, SUM(SoLuongSanPham) as SoLuongSanPham
		from QuanAo, ChiTietBanHang
		where QuanAo.ID_QA = ChiTietBanHang.ID_QA
		group by Ten_QA
		order by SoLuongSanPham desc
	end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_select_sanphambandduoc]
(@ID_QA int)
as
begin
select  SUM(SoLuongSanPham) as SoLuongSanPham
from QuanAo, ChiTietBanHang
where QuanAo.ID_QA = ChiTietBanHang.ID_QA and QuanAo.ID_QA =  @ID_QA
end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_QuanAo_By_Price 150000, 200000
-- GO

CREATE PROCEDURE [dbo].[sp_select_search_QuanAo_GiaCa]
@ten NVARCHAR(255),
@GiaBanThap FLOAT, 
@GiaBanCao FLOAT
AS
BEGIN
	SELECT 
		ID_QA, 
		Ten_QA, 
		Size, 
		GiaBan, 
		SoLuong, 
        CASE 
            WHEN LEN(GhiChu) > 150 THEN SUBSTRING(GhiChu, 1, 150) + ' ...'      
			ELSE GhiChu      
		END AS [GhiChu], 
		LoaiQA.ID_LQA, 
		Ten_LQA
	FROM QuanAo
	JOIN LoaiQA ON QuanAo.ID_LQA = LoaiQA.ID_LQA
	WHERE
		QuanAo.Is_Alive = 1 AND LoaiQA.Is_Alive = 1 AND
		dbo.fuConvertToUnsign1(Ten_QA) LIKE '%' + dbo.fuConvertToUnsign1(@ten) + '%' AND
		(@GiaBanThap <= GiaBan AND GiaBan <= @GiaBanCao)
		
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_Master_LoaiQA
-- GO

CREATE PROCEDURE [dbo].[sp_select_SoLuongSanPham_by_ID_LQA]
@ID_LQA INT
AS
BEGIN
	SELECT COUNT(*) FROM LoaiQA
	JOIN QuanAo ON LoaiQA.ID_LQA = QuanAo.ID_LQA
	WHERE LoaiQA.ID_LQA = @ID_LQA AND LoaiQA.Is_Alive = 1
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- EXEC sp_select_KhachHang_By_KeyWord 'hieu'
-- EXEC sp_select_KhachHang_By_KeyWord '037'

CREATE PROC [dbo].[sp_select_TimKiemKhachHang]
@SDT VARCHAR(10)
AS
BEGIN
	SELECT * FROM KhachHang
	WHERE KhachHang.SDT LIKE '%'+@SDT+'%'
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_select_top5KhachHangcosolanmuahangnhieunhat]
as
	begin
		SELECT ID_KH,HoTen
		FROM KhachHang
		WHERE ID_KH IN (
			SELECT TOP 5 ID_KH
			FROM BanHang
			GROUP BY ID_KH
			ORDER BY COUNT(DISTINCT ID_BH) DESC
		)
	end
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_KhachHang_By_ID 1
-- GO

CREATE PROCEDURE [dbo].[sp_selectKhachHang_By_SDT]
@sdt NVARCHAR(50)
AS
BEGIN
	SELECT * FROM KhachHang WHERE SDT = @sdt
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_insert_BanHang_ChuaThanhToan N'Nguyễn Trọng Hiếu', N'0374408253', N'Đà Lạt';
-- GO

-- SELECT * FROM KhachHang

-- EXEC sp_select_BanHang_ChuaThanhToan_By_KhachHang 1

-- SELECT * FROM BanHang;
-- GO

-- THANH TOÁN ĐƠN HÀNG
CREATE PROCEDURE [dbo].[sp_ThanhToanBanHang]
@ID_BH INT, @ID_GD NVARCHAR(30), @discount FLOAT
AS
BEGIN
	IF (EXISTS (SELECT * FROM BanHang WHERE ID_BH = @ID_BH AND ID_GD <> NULL))
		RETURN

	UPDATE BanHang
	SET
		ID_GD = @ID_GD,
		Discount = @discount
	WHERE ID_BH = @ID_BH
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create proc [dbo].[Sp_ThongKeMatHangBanDuocTrongMoiThangVaTrongCaNam]
(@YEAR int
)
AS
BEGIN
SELECT b.ID_QA,Ten_QA, 
	SUM(CASE MONTH(NgayBanHang) WHEN 1 THEN b.SoLuongSanPham ELSE 0 END) AS Thang1,
	SUM(CASE MONTH(NgayBanHang) WHEN 2 THEN b.SoLuongSanPham ELSE 0 END) AS Thang2,
	SUM(CASE MONTH(NgayBanHang) WHEN 3 THEN b.SoLuongSanPham ELSE 0 END) AS Thang3,
	SUM(CASE MONTH(NgayBanHang) WHEN 4 THEN b.SoLuongSanPham ELSE 0 END) AS Thang4,
	SUM(CASE MONTH(NgayBanHang) WHEN 5 THEN b.SoLuongSanPham ELSE 0 END) AS Thang5,
	SUM(CASE MONTH(NgayBanHang) WHEN 6 THEN b.SoLuongSanPham ELSE 0 END) AS Thang6,
	SUM(CASE MONTH(NgayBanHang) WHEN 7 THEN b.SoLuongSanPham ELSE 0 END) AS Thang7,
	SUM(CASE MONTH(NgayBanHang) WHEN 8 THEN b.SoLuongSanPham ELSE 0 END) AS Thang8,
	SUM(CASE MONTH(NgayBanHang) WHEN 9 THEN b.SoLuongSanPham ELSE 0 END) AS Thang9,
	SUM(CASE MONTH(NgayBanHang) WHEN 10 THEN b.SoLuongSanPham ELSE 0 END) AS Thang10,
	SUM(CASE MONTH(NgayBanHang) WHEN 11 THEN b.SoLuongSanPham ELSE 0 END) AS Thang11,
	SUM(CASE MONTH(NgayBanHang) WHEN 12 THEN b.SoLuongSanPham ELSE 0 END) AS Thang12,
	SUM(b.SoLuongSanPham) AS CaNam
FROM (BanHang AS a INNER JOIN ChiTietBanHang AS b 
ON a.ID_BH=b.ID_BH) 
INNER JOIN QuanAo AS c ON b.ID_QA =c.ID_QA
WHERE YEAR(NgayBanHang) = @YEAR
GROUP BY b.ID_QA,Ten_QA
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_select_BanHang_By_KhachHang_SDT '0374408253';
-- GO

CREATE PROC [dbo].[sp_TinhTongTienChuaGiamGia]
@fromdate DATE, @todate DATE
AS
BEGIN
	SELECT SUM(ChiTietBanHang.SoLuongSanPham * QuanAo.GiaBan) FROM ChiTietBanHang
	JOIN QuanAo	ON ChiTietBanHang.ID_QA = QuanAo.ID_QA
	JOIN BanHang ON ChiTietBanHang.ID_BH = BanHang.ID_BH
	WHERE @fromdate <= NgayBanHang AND NgayBanHang<=@todate
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_TinhTongTienChuaGiamGia '20201201', '20201231';
-- GO

CREATE PROC	[dbo].[sp_TinhTongTienGiamGia] 
@fromdate DATE, @todate DATE
AS
BEGIN
	SELECT SUM(ChiTietBanHang.SoLuongSanPham*QuanAo.GiaBan*(BanHang.Discount/100)) FROM ChiTietBanHang
	JOIN QuanAo	ON ChiTietBanHang.ID_QA = QuanAo.ID_QA
	JOIN BanHang ON ChiTietBanHang.ID_BH = BanHang.ID_BH
	WHERE @fromdate <= NgayBanHang AND NgayBanHang<=@todate
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_insert_LoaiQuanAo N'Áo sơ mi'
-- GO
-- SELECT * FROM LoaiQA
-- GO

CREATE PROCEDURE [dbo].[sp_update_LoaiQuanAo]
@ID_LQA INT, @Ten_LQA NVARCHAR(30)
AS
BEGIN
	UPDATE dbo.LoaiQA
	SET
		[Ten_LQA] = @Ten_LQA
	WHERE ID_LQA = @ID_LQA
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_insert_QuanAo N'Quan ao moi', 'M', 20000, 10, 'ghi chu', 1, null, null
-- GO

CREATE PROCEDURE [dbo].[sp_update_QuanAo]
@ID_QA INT,
@Ten_QA NVARCHAR(100),
@Size CHAR(5),
@GiaBan FLOAT,
@SoLuong INT,
@GhiChu NVARCHAR(MAX),
@ID_LQA INT,
@HinhQA IMAGE,
@HinhQAP NVARCHAR(MAX)
AS
BEGIN
	IF (@ID_LQA IS NULL OR @ID_LQA = '')
		RETURN

	IF (NOT EXISTS(SELECT * FROM LoaiQA WHERE LoaiQA.ID_LQA = @ID_LQA))
		RETURN

	IF (NOT EXISTS (SELECT * FROM QuanAo WHERE QuanAo.ID_QA = @ID_QA))
		RETURN	

	UPDATE QuanAo
	SET
		Ten_QA = @Ten_QA,
		Size = @Size,
		GiaBan = @GiaBan,
		SoLuong = @SoLuong,
		GhiChu = @GhiChu,
		ID_LQA = @ID_LQA
	WHERE ID_QA = @ID_QA AND QuanAo.Is_Alive = 1

	IF (@HinhQA IS NULL OR @HinhQAP IS NULL OR @HinhQAP = '')
		RETURN

	IF (NOT EXISTS(SELECT * FROM HinhQA WHERE ID_QA = @ID_QA))
	BEGIN
		INSERT HinhQA(HinhQA, HinhQAP, ID_QA)
		VALUES (@HinhQA, @HinhQAP, @ID_QA)
	END
	ELSE
	BEGIN
		UPDATE HinhQA
		SET
			HinhQA = @HinhQA,
			HinhQAP = @HinhQAP
		WHERE ID_QA = @ID_QA
	END
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- EXEC sp_delete_BanHang 8
-- GO

CREATE PROC [dbo].[USP_HaOcCho]
@message NVARCHAR(100)
AS
BEGIN
	DECLARE @ngaySinh DATETIME = '20002010';

	
END
GO
USE [master]
GO
ALTER DATABASE [QL_ShopQuanAo] SET  READ_WRITE 
GO
