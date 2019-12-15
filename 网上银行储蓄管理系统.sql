/*==============================================================*/
/* DBMS name:      ADABAS D                                     */
/* Created on:     2019/7/1 16:38:51                            */
/*==============================================================*/


drop table 代理单表;

drop table 信用卡表;

drop table 储户表;

drop table 利息表;

drop table 取款单表;

drop table 存款单表;

drop table 挂失单表;

drop table 管理员;

drop table 缴费投保记录表;

drop table 账户表;

drop table 贷款表;

drop table 转帐单号;

drop table 还款记录表;

drop table 销户单表;

/*==============================================================*/
/* Table: 代理单表                                                  */
/*==============================================================*/
create table 代理单表 (
代理编号 varchar(10) not null,
户号 varchar(20),
代理名称 varchar(50) not null,
代理业务 varchar(50) not null,
代理备注 varchar(50),
primary key (代理编号)
);

/*==============================================================*/
/* Table: 信用卡表                                                  */
/*==============================================================*/
create table 信用卡表 (
卡号 varchar(20) not null,
户号 varchar(20),
持卡人姓名 varchar(10) not null,
卡余额 money not null,
信用额度 money not null,
信用状态 varchar(10) not null,
信用卡备注 varchar(50),
primary key (卡号)
);

alter table 信用卡表
   add default(5000) for 信用额度

/*==============================================================*/
/* Table: 储户表                                                   */
/*==============================================================*/
create table 储户表 (
储户身份证号 varchar(18) not null,
储户姓名 varchar(10) not null,
储户联系方式 varchar(20),
储户照片 image,
储户储蓄备注 varchar(50),
primary key (储户身份证号)
);

/*==============================================================*/
/* Table: 利息表                                                   */
/*==============================================================*/
create table 利息表 (
利息编号 varchar(10) not null,
类型 varchar(20) not null,
利率 float not null,
期限 int not null check(期限>0),
primary key (利息编号)
);

go
insert into 利息表(利息编号,类型,利率,期限)values('1001','活期存款',0.0005,30)
insert into 利息表(利息编号,类型,利率,期限)values('1002','活期存款',0.00045,60)
insert into 利息表(利息编号,类型,利率,期限)values('1003','定期存款',0.00065,180)
insert into 利息表(利息编号,类型,利率,期限)values('1004','定期存款',0.0007,360)
 


/*==============================================================*/
/* Table: 取款单表                                                  */
/*==============================================================*/
create table 取款单表 (
取款单号 int not null identity(1,1),
户号 varchar(20),
工号 varchar(20),
取款金额 money not null,
利息 money not null,
应得金额 money not null,
取款日期 date not null,
账户余额 money not null,
primary key (取款单号)
);

alter table 取款单表
  drop column 取款类型
  select * from 取款单表
   drop table 取款单表

/*==============================================================*/
/* Table: 存款单表                                                  */
/*==============================================================*/
create table 存款单表 (
存款单号 int not null identity(1,1),
工号 varchar(20),
户号 varchar(20),
存款金额 money not null,
存款日期 date not null default(getdate()),
存款类型 varchar(20) not null,
primary key (存款单号)
);

/*==============================================================*/
/* Table: 挂失单表                                                  */
/*==============================================================*/
create table 挂失单表 (
余额 money not null,
挂失日期 date not null default(getdate()),
挂失单号 int not null identity(1,1),
工号 varchar(20),
户号 varchar(20),
primary key (挂失单号)
);

/*==============================================================*/
/* Table: 管理员                                                   */
/*==============================================================*/
create table 管理员 (
工号 varchar(20) not null,
管理员密码 varchar(10) not null,
管理员级别 integer not null,
管理员姓名 varchar(10) not null,
管理员身份证 varchar(18) not null,
管理员联系方式 varchar(20),
管理员住址 varchar(80),
管理员照片 image,
管理员备注 varchar(50),
primary key (工号)
);

/*==============================================================*/
/* Table: 缴费投保记录表                                               */
/*==============================================================*/
create table 缴费投保记录表 (
投保编号 int not null identity(1,1),
户号 varchar(20),
投保名称 varchar(50) not null,
投保人姓名 varchar(10) not null,
投保人身份证号 varchar(18) not null,
到期时间 date not null,
投保金额 money not null,
投保备注 varchar(50),
primary key (投保编号)
);

/*==============================================================*/
/* Table: 账户表                                                   */
/*==============================================================*/
create table 账户表 (
户号 varchar(20) not null,
储户身份证号 varchar(18),
密码 varchar(10) not null,
金额 money not null,
开户日期 date not null ,
开户地 varchar(50) not null,
是否贵宾 varchar(6) not null,
挂失账户 varchar(6) not null ,
用户备注 varchar(50),
primary key (户号)
);

/*==============================================================*/
/* Table: 贷款表                                                   */
/*==============================================================*/
create table 贷款表 (
贷款编号 int not null identity(1,1),
户号 varchar(20),
贷款人姓名 varchar(10) not null,
贷款人身份证号 varchar(18) not null,
贷款人联系方式 varchar(20) not null,
贷款金额 money not null,
贷款期限 varchar(20) not null,
还款利率 float not null,
放款日期 date not null ,
到期日期 date not null,
每月应还 money not null,
贷款备注 varchar(50),
primary key (贷款编号)
);

/*==============================================================*/
/* Table: 转帐单号                                                  */
/*==============================================================*/
create table 转帐单号 (
转账单号 int not null identity(1,1),
工号 varchar(20),
户号 varchar(20),
转出户号 varchar(20) not null,
转入户号 varchar(20) not null,
转账金额 money not null,
转账日期 date not null default(getdate()),
手续费 money not null,
primary key (转账单号)
);

/*==============================================================*/
/* Table: 还款记录表                                                 */
/*==============================================================*/
create table 还款记录表 (
还款编号 int not null identity(1,1),
户号 varchar(20),
贷款编号 varchar(10),
还款日期 date not null default(getdate()),
还款金额 money not null,
是否违约 varchar(6) not null default '否',
primary key (还款编号)
);

/*==============================================================*/
/* Table: 销户单表                                                  */
/*==============================================================*/
create table 销户单表 (
销户单号 int not null identity(1,1),
工号 varchar(20),
户号 varchar(20),
销户前余额 money not null,
销户日期 date not null default(getdate()),
primary key (销户单号)
);

drop table 销户单表

alter table 代理单表
   add constraint  FK_代理单表_代缴_账户表 foreign key(户号)
      references 账户表 (户号)
      --on delete restrict;

alter table 信用卡表
   add constraint FK_信用卡表_拥有卡_账户表 foreign key(户号)
      references 账户表 (户号)
      --on delete restrict;

alter table 取款单表
   add constraint FK_取款单表_RELA_管理员 foreign key(工号)
      references 管理员 (工号)
      --on delete restrict;

alter table 取款单表
   add constraint FK_取款单表_取款_账户表 foreign key(户号)
      references 账户表 (户号) on delete cascade
      --on delete restrict;

alter table 取款单表
   drop constraint FK_取款单表_取款_账户表 

alter table 存款单表
   add constraint FK_存款单表_存款_账户表 foreign key(户号)
      references 账户表 (户号)
      --on delete restrict;

alter table 存款单表
   add constraint FK_存款单表_存款操作_管理员 foreign key(工号)
      references 管理员 (工号)
      --on delete restrict;

alter table 取款单表
   add constraint FK_取款单表_取款操作_管理员 foreign key(工号)
      references 管理员 (工号)
      --on delete restrict;

alter table 挂失单表
   add constraint FK_挂失单表_挂失_账户表 foreign key(户号)
      references 账户表 (户号)
      --on delete restrict;

alter table 挂失单表
   add constraint FK_挂失单表_挂失操作_管理员 foreign key(工号)
      references 管理员 (工号)
      --on delete restrict;

alter table 缴费投保记录表
   add constraint FK_缴费投保_投保_账户表 foreign key(户号)
      references 账户表 (户号)
      --on delete restrict;

alter table 账户表
   add constraint FK_账户表_拥有账户_储户表 foreign key(储户身份证号)
      references 储户表 (储户身份证号)
      --on delete restrict;

alter table 贷款表
   add constraint FK_贷款表_贷款_账户表 foreign key(户号)
      references 账户表 (户号)
      --on delete restrict;

alter table 转帐单号
   add constraint FK_转帐单号_转账_账户表 foreign key(户号)
      references 账户表 (户号)
      --on delete restrict;

alter table 转帐单号
   add constraint FK_转帐单号_转账操作_管理员 foreign key(工号)
      references 管理员 (工号)
      --on delete restrict;

alter table 还款记录表
   add constraint FK_还款记录_贷款还款_贷款表 foreign key(贷款编号)
      references 贷款表 (贷款编号)
      --on delete restrict;

alter table 还款记录表
   add constraint FK_还款记录_还款_账户表 foreign key(户号)
      references 账户表 (户号)
      --on delete restrict;

alter table 销户单表
   add constraint FK_销户单表_销户_账户表 foreign key(户号)
      references 账户表 (户号)
      --on delete restrict;

alter table 销户单表
   add constraint FK_销户单表_销户操作_管理员 foreign key(工号)
      references 管理员 (工号)
      --on delete restrict;

alter table 取款单表
   add default(getdate()) for 取款日期 

alter table 账户表
   add default(getdate()) for 开户日期

alter table 储户表
   add  default(0xFFFFFFFF) for 储户照片

alter table 管理员
   add  default(0xFFFFFFFF) for 管理员照片

alter table 账户表
  add default('否') for 是否贵宾

alter table 存款单表
   add check(存款类型 in('活期存款','定期存款'))

alter table 缴费投保记录表
  add constraint 社保类型 check(投保名称 in('车辆保险','医疗保险','人寿保险'))

--设置两位登入用户：小明（只有用户的权限），小红（只有用户的权限）
go
exec sp_addlogin '小明','1314250'
exec sp_addlogin '小红','1314520'

go
use 网上储蓄银行管理系统
exec sp_grantdbaccess '小明','用户小明'
exec sp_grantdbaccess '小红','用户小红'

--设置两位管理人员：大明（权限最高），大红（部分权限）
go
exec sp_addlogin '大明','886110'
exec sp_addlogin '大红','110886'

go
use 网上储蓄银行管理系统
exec sp_grantdbaccess '大明','管理者大明'
exec sp_grantdbaccess '大红','管理者大红'

go--创建储户账号
create proc createSaving
@储户身份证号  varchar(18),
@储户姓名      varchar(10),
@储户联系方式  varchar(20),
@储户储蓄备注  varchar(50)
as
begin
   insert into 储户表(储户身份证号,储户姓名,储户联系方式,储户储蓄备注) values(@储户身份证号,@储户姓名,@储户联系方式,@储户储蓄备注)
end

exec createSaving '35082219981012','小明','18059828960','新用户'
exec createSaving '35082219981112','小红','18659728960','新用户'
exec createSaving '35082219881112','小兰','17659728960','新用户'
exec createSaving '35082219990709','小妍','18020627895','新用户'
select * from 储户表

go--账户表创建
create proc createAccount
@户号    varchar(20),
@储户身份证号  varchar(18),
@密码    varchar(10),
@金额    money,
@开户地  varchar(50),
@用户备注 varchar(50)
as
begin
  if not exists(select * from 储户表 where 储户身份证号 = @储户身份证号)
    begin
      print'不存在该储户，请先成为储户!'
	  rollback
    end
  else
    insert into 账户表 (户号,储户身份证号,密码,金额,开户地,用户备注)values(@户号,@储户身份证号,@密码,@金额,@开户地,@用户备注)
end

exec createAccount '201721121019','35082219981012','07091012','1000','福建省厦门市建设银行','新开户用户'
exec createAccount '201721121020','35082219981112','1012llq','1000','福建省厦门市建设银行','新开户用户'
exec createAccount '201821121020','35082219981112','hhhllq','10000','福建省厦门市建设银行','新开户用户'
exec createAccount '201821121029','35082219981112','h85llq','10000','福建省厦门市工商银行','新开户用户'
exec createAccount '211210198548','35082219990709','liadhsj','10000','福建省厦门市工商银行','新开户用户' 
select * from 账户表

select * from 储户表
select * from 管理员
go--信息加密
create proc 加密
@工号   nvarchar(20),
@身份证 nvarchar(20),
@姓名   nvarchar(10)
as
begin
--创建数据库主密钥
--go
if exists(select * from 储户表 where 储户身份证号 = @身份证)
begin
   if exists(select * from 管理员 where 工号 = @工号)
    begin
	create table 加密信息(
	身份证   varbinary(5000),
	姓名     nvarchar(10)
	);
--alter table 加密 add 姓名 nvarchar(10)
--select 身份证 = 储户身份证号,姓名 = 储户姓名 into 加密信息 from 储户表 
	CREATE MASTER KEY ENCRYPTION BY PASSWORD = '123456'; 

--创建证书，使用该数据库主密钥加密
--go
	CREATE CERTIFICATE TestCert with SUBJECT = '123456'

--创建一个对称秘钥
--GO
	CREATE SYMMETRIC KEY TestSymmetric WITH ALGORITHM = AES_256
	ENCRYPTION BY CERTIFICATE TestCert 
--GO

--加密数据
	OPEN SYMMETRIC KEY TestSymmetric DECRYPTION BY CERTIFICATE TestCert;
	INSERT INTO 加密信息(身份证,姓名) values(ENCRYPTBYKEY(Key_Guid(N'TestSymmetric'), @身份证),@姓名);
	CLOSE SYMMETRIC KEY TestSymmetric;
--GO

--解密数据
--GO
	--OPEN SYMMETRIC KEY TestSymmetric DECRYPTION BY CERTIFICATE TestCert;
	--SELECT 姓名, CAST(DecryptByKey(身份证) as varchar(100)) 解密结果 FROM 加密信息;
	--CLOSE SYMMETRIC KEY TestSymmetric;
	end
	else
     begin
       print'不存在此管理员！'
       rollback
     end
  end
else
     begin
       print'不存在此储蓄用户！'
       rollback
     end
end

exec 加密 '20168851159','35082219881112','小兰'
select * from 加密信息
drop proc 加密


go--管理员创建
create proc createAdmin
@工号        varchar(20),
@管理员密码  varchar(10),
@管理员级别  integer,
@管理员姓名  varchar(10),
@管理员身份证 varchar(18),
@管理员联系方式 varchar(20),
@管理员住址   varchar(80),
@管理员备注   varchar(50)
as
begin
  insert into 管理员(工号,管理员密码,管理员级别,管理员姓名,管理员身份证,管理员联系方式,管理员住址,管理员备注)values(@工号,@管理员密码,@管理员级别,@管理员姓名,@管理员身份证,@管理员联系方式,@管理员住址,@管理员备注)
  exec 管理员权限赋予 @工号,@管理员密码
end
 
 exec createAdmin '20178859998','gly110',1,'大明','350822199110125565','13055853008','福建省厦门市云顶楼56号','1级管理员'
 exec createAdmin '20168851159','gly007',2,'大红','350822199210123369','13055842292','福建省厦门市芸韵花园12号','2级管理员'
 select * from 管理员
 drop proc createAdmin

go--存款(只能选择两种存款方式（活期存款，定期存款）)
create proc	Deposit
@工号 varchar(20),
@户号 varchar(20),
@存款金额 money,
@存款类型 varchar(20),
@账户密码    varchar(10)
as
begin
   if not exists(select * from 管理员 where 工号 = @工号)
     begin
	   print'该管理人员不存在！请选择合理的管理人员为你服务！'
	   rollback
	 end
	else
   begin
	  if not exists(select * from 账户表 where 户号 = @户号)
	    begin
		   print'该账户不存在'
		   rollback
		end
	  else
	    begin
		   if not exists(select * from 账户表 where 密码 = @账户密码)
		     begin
			    print'密码错误！请重新输入密码！'
				rollback
		     end
		   else
		     begin
			    insert into 存款单表(工号,户号,存款金额,存款类型)values(@工号,@户号,@存款金额,@存款类型)
				update 账户表
				set 金额 = @存款金额 + 金额  
				where 户号 = @户号 and 密码 = @账户密码 
			 end
		 end
	end
end

exec Deposit '20168851159','211210198548','5000','活期存款','liadhsj'
select * from 存款单表
select * from 账户表
drop proc Deposit

go--销户
create proc deleteAccount
@户号     varchar(20),
@密码    varchar(10),
@工号    varchar(20)
as
begin
   if not exists(select * from 账户表 where 户号 = @户号 and 密码 = @密码)
     begin
	   print'该账户不存在！！'
	   rollback 
	 end

   else
     begin
	 if exists(select * from 管理员 where 工号 = @工号 and 管理员级别 = 1)
	   begin
	     --select * from 销户单表
		 declare @销户前余额 money
		 select @销户前余额 = 金额 from 账户表 where 户号 = @户号
	     insert into 销户单表(工号,户号,销户前余额) values(@工号,@户号,@销户前余额)
	     delete from 账户表 where 户号 = @户号 and 密码 = @密码
	   end
	  else
	    begin
		  print'您的管理员等级较低，无法进行该操作！'
		end
	 end
end
exec deleteAccount '201721121020','1012llq','20178859998'
select * from 销户单表
drop proc deleteAccount

go--挂失
create proc reportLoss
@户号    varchar(20),
@密码    varchar(10),
@工号    varchar(20)
as
begin
if exists(select * from 管理员 where 工号 = @工号 and 管理员级别 >= 2)
 begin
  update 账户表
  set 挂失账户 = '是'
  where 户号 = @户号 and 密码 = @密码
  declare @余额 money
  select @余额 = 金额 from 账户表 where 户号 = @户号 
  insert into 挂失单表(余额,工号,户号) values(@余额,@工号,@户号)
 end
else
 begin
  print'您的等级不够，不能处理此操作！'
  rollback
 end
end

exec reportLoss '201821121029','h85llq','20168851159'
select  * from 挂失单表
select  * from 账户表
drop proc reportLoss

go--取消挂失
create proc cancleReportLoss
@户号    varchar(20),
@密码    varchar(10),
@工号    varchar(20)
as
begin
if exists(select * from 管理员 where 工号 = @工号 and 管理员级别 >= 2)
  begin
      update 账户表
      set 挂失账户 = '否'
      where 户号 = @户号 and 密码 = @密码
      delete from 挂失单表 where 户号 = @户号
  end
end
drop proc cancleReportLoss


go--修改管理员密码
create proc modifyPassword
@工号        varchar(20),
@管理员密码  varchar(10),
@管理员身份证 varchar(18)
as
begin
  update 管理员
  set 管理员密码 = @管理员密码
  where 工号 = @工号 and 管理员身份证 = @管理员身份证
end

exec modifyPassword '','',''

go--验证管理员密码
create function checkPassword(@工号 varchar(20),@密码 varchar(10))
returns int
as
begin
  declare @password int
    begin
      select @password = 管理员密码 from 管理员 where 工号 = @工号
    end
  if(@密码 = @password)
    begin
	  return 1
	end
   else
   begin
      return 0
   end   
 return 0
end

go--判断管理员级别（进入高级管理功能的必须）
create function checkManagerlevel(@工号 varchar(20))
returns int as
begin
declare @level int
begin
    select @level=管理员级别 from 管理员
    where 工号=@工号
end
return @level
end


go--取款
create procedure 取款操作
	@工号 varchar(20),
	@户号 varchar(20),
	@密码 varchar(10),
	@金额 money
as
begin

	declare 
			@余额 money,
			@利息 money,
			@取款时间  date
	set @取款时间 = getdate()
	if(not exists (select * from 管理员 where @工号 = 工号))
		begin
			print'无此管理员'
			return
		end
	if(not exists (select * from 账户表 where @户号=户号))
		begin
			print'无此账户'
			return
		end
	else
		begin
			if((select 密码 from 账户表 where @户号=户号)!= @密码)
				begin
					print'密码错误'
					return
				end
			else if ((select 挂失账户 from 账户表 where @户号 = 户号) = '是')
				begin
					print'此账户已挂失'
					return
				end
			else if((select 金额 from 账户表 where @户号 = 户号) < @金额)
				begin
					print'余额不足'
					return
				end
			else 
				begin
					set @利息 = dbo.calculateInterest(@户号)
					set @余额 = (select 金额 from 账户表 where 户号 = @户号)
					set @余额 = @余额+@利息-@金额
					update 账户表
					set 金额 = @余额
					where 户号 = @户号
					insert into 取款单表(户号,工号,取款金额,利息,应得金额,取款日期,账户余额)
					values(@户号,@工号,@金额,@利息,@金额+@利息,@取款时间,@余额)
					print'取款成功'
				end
		end

end


exec 取款操作 '20168851159','211210198548','liadhsj',10000
exec 取款操作 'sadsa','201721121019','07091012',11
exec 取款操作 '20168851159','dagare','07091012',11
exec 取款操作 '20168851159','201721121019','fadgfsg',11
exec 取款操作 '20168851159','201721121019','07091012',110000
exec 取款操作 '20178859998','201821121020','hhhllq',1000
select * from 取款单表
select * from 账户表
select * from 利息表
select * from 管理员
drop procedure 取款操作

go--利息
create function calculateInterest(@id varchar(20))
returns money as
begin

declare @interest money,@starttime datetime,@type nvarchar(4),@deposit float,@durtime int,@save money
begin
	select @starttime=存款日期,@type=存款类型 from 存款单表 where 户号=@id
	select @deposit=利率,@durtime=期限 from 利息表 where 类型=@type
	  if(datediff(m,@starttime,GETDATE())>=@durtime)

        begin

            select @save=存款金额 from 存款单表 where 户号=@id

            set @interest=power((1+@deposit),(@durtime/12))-@save

        end

    else

        begin

            return 0

        end

end

return @interest

end

select 利息=dbo.calculateInterest('201721121019')

go--转帐
create procedure 转帐操作
	@工号 varchar(20),
	@户号 varchar(20),
	@密码 varchar(20),
	@转入户号 varchar(20),
	@金额 money
as
	
	begin
	declare 
			@余额 money,
			@利息 money,
			@手续费 money
	set @手续费 = @金额 * 0.001
	if(not exists (select * from 管理员 where @工号 = 工号))
		begin
			print'无此管理员'
			return
		end
	if(not exists (select * from 账户表 where @户号=户号))
		begin
			print'无此账户'
			return
		end
	if(not exists (select * from 账户表 where @转入户号=户号))
		begin
			print'无转入账户'
			return
		end
	else
		begin
			if((select 密码 from 账户表 where @户号=户号)!= @密码)
				begin
					print'密码错误'
					return
				end
			else if ((select 挂失账户 from 账户表 where @户号 = 户号) = '是')
				begin
					print'此账户已挂失'
					return
				end
			else if((select 挂失账户 from 账户表 where @转入户号 = 户号) = '是')
				begin
					print'目标账户已挂失'
					return
				end
			else if((select 金额 from 账户表 where @户号 = 户号) < (@金额-@手续费))
				begin
					print'余额不足'
					return
				end
			else 
				begin
					set @利息 = dbo.calculateInterest(@户号)
					set @余额 = (select 金额 from 账户表 where 户号 = @户号)
					set @余额 = @余额+@利息-@金额-@手续费
					update 账户表
					set 金额 = @余额
					where 户号 = @户号
					update 账户表
					set 金额 = 金额  + @金额
					where 户号=@转入户号
					insert into 转帐单号(工号,户号,转出户号,转入户号,转账金额,手续费)
					values(@工号,@户号,@户号,@转入户号,@金额,@手续费)
					print'转帐成功'
				end
		end
	end
go
drop proc 转帐操作

exec  转帐操作 '20178859998','201821121029','h85llq','211210198548',5000
exec  转帐操作 '432332','201721121019','07091012','201721121020',22
exec  转帐操作 '20178859998','324234','07091012','201721121020',22
exec  转帐操作 '20178859998','201721121019','0709132432012','201721121020',22
exec  转帐操作 '20178859998','201721121019','07091012','32432',22
exec  转帐操作 '20178859998','201721121019','07091012','201721121020',100000
select * from 账户表
select * from 转帐单号

select * from 账户表
go--判断账户是否挂失
create function checkAccount(@户号 varchar(20))
returns nvarchar(6) 
as
begin
declare @state nvarchar(6)
begin
    select @state=挂失账户 from 账户表
    where 户号=@户号
end
if(@state='否')
    begin
        return '否'
    end
else if(@state='是')
    begin
        return '是'
    end
return 0
end

drop function checkAccount
select 是否挂失 = dbo.checkAccount('201721121020')

go--判断账户是否存在
create function judgeexist(@户号 varchar(20))
returns nvarchar(6) 
as
begin
declare @idn varchar(20)
set @idn=(select 户号 from 账户表 where 户号=@户号)
if(@idn is not null)
    begin
        return '存在'
    end
return 0
end
select 账户是否存在 = dbo.judgeexist('201721121020')

go--打印存款明细单
create procedure printdepositdetail 
@户号 varchar(20) 
as
select * from 存款单表
where 户号=@户号
exec printdepositdetail '201721121019'

go--打印取款明细单
create procedure printdrawdetail 
@户号 varchar(20) 
as
select * from 取款单表
where 户号=@户号

go--打印转帐明细单
create procedure printtransdetail 
@户号 varchar(20) as
select * from 转帐单号
where 转出户号=@户号
exec printtransdetail '201721121019'
select * from 转帐单号


go--修改储户联系方式
create procedure altercontact 
@储户身份证号码 varchar(18),
@联系方式 varchar(20) 
as
update 储户表
set 储户联系方式=@联系方式
where 储户身份证号=@储户身份证号码
select * from 储户表

go--信用卡开户
create proc createCreditAccount
@卡号 varchar(20),
@户号 varchar(20),
@持卡人姓名 varchar(10),
@信用状态 varchar(10),
@信用卡备注 varchar(50)
as
begin
   if exists(select * from 账户表 where 户号 = @户号 )
      begin
	    declare @余额 money
		select @余额 = 金额 from 账户表 where 户号 = @户号
		insert into 信用卡表(卡号,户号,持卡人姓名,卡余额,信用状态,信用卡备注) values(@卡号,@户号,@持卡人姓名,@余额,@信用状态,@信用卡备注)
	  end
	else
	  begin
	    print'没有此用户！'
		rollback
	  end
end 
exec createCreditAccount '6237145698852','201821121020','小兰','信用良好','新用户开通信用卡'
exec createCreditAccount '6237145675852','201821121020','小明','信用良好','新用户开通信用卡'
select * from 信用卡表
drop proc createCreditAccount

go--信用卡额度修改
create proc correctCreditLimit
@卡号 nvarchar(20),
@工号 nvarchar(20),
@额度 money
as
begin
  if not exists(select * from 信用卡表 where 卡号 = @卡号)
     begin
	   print'信用卡不存在！'
	   rollback
	 end
   if exists(select * from 管理员 where 工号 = @工号 and 管理员级别 = 1)
     begin
	   update 信用卡表
	   set 信用额度 = @额度
	   where 卡号 = @卡号
	 end
	else
	  begin
	    print'您没有修改额度的权限'
		rollback
	  end
end
exec correctCreditLimit '6237145675852','20178859998','50000'
select * from 信用卡表
drop proc correctCreditLimit

go--贷款
create proc createLoan
@户号 varchar(20),
@贷款人姓名 varchar(10),
@贷款人身份证号 varchar(18),
@贷款人联系方式 varchar(20),
@贷款金额 money ,
@贷款期限 varchar(20),
@放款日期 date,
@到期日期 date ,
@贷款备注 varchar(50)
as
--select * from 贷款表
begin
   if not exists(select * from 储户表 where 储户姓名 = @贷款人姓名 and 储户身份证号 = @贷款人身份证号)
      begin
	    print'没有该储户信息！无法贷款！'
		rollback
	  end
   else
      begin
	    if not exists(select * from 账户表 where 户号 = @户号)
		   begin
		      print'请先注册一个账户！'
		   end
		else
		   begin
		      declare @cost money,@还款利率  float
		      if(@贷款金额 < =10000)
		         begin
				   set  @还款利率 = 0.005
				   set @cost = datediff(MM,@放款日期,@到期日期) * @还款利率 * @贷款金额
				 end
			  if(@贷款金额 >10000 and @贷款金额 <= 100000)
			     begin
				   set  @还款利率 = 0.004
				   set @cost = datediff(MM,@放款日期,@到期日期) * @还款利率 * @贷款金额
				 end
			  else
			     begin
				   set  @还款利率 = 0.003
				   set @cost = datediff(MM,@放款日期,@到期日期) * @还款利率 * @贷款金额
			     end
		      insert into 贷款表(户号,贷款人姓名,贷款人身份证号,贷款人联系方式,贷款金额,贷款期限,还款利率,放款日期,到期日期,每月应还,贷款备注)values(@户号,@贷款人姓名,@贷款人身份证号,@贷款人联系方式,@贷款金额,@贷款期限,@还款利率,@放款日期,@到期日期,@cost,@贷款备注)
		   end
	  end
end
exec createLoan '201821121020','小红','35082219981112','18659728960','200000','五个月','2019-5-1','2019-10-1','贷款买车'
select * from 账户表
select * from 储户表
SELECT * FROM 贷款表
drop proc createLoan

go--投保缴费
create proc createInsurance
@户号 nvarchar(20),
@投保名称  nvarchar(10),
@投保人姓名 nvarchar(10),
@投保人身份证号 nvarchar(18),
@到期时间   date,
@投保金额   money,
@投保备注   nvarchar(50)
as
begin
   if not exists(select * from 储户表 where 储户姓名 = @投保人姓名 and 储户身份证号 = @投保人身份证号)
      begin
	    print'没有该储户信息！无法投保！'
		rollback
	  end
   else
      begin
	    if not exists(select * from 账户表 where 户号 = @户号)
		   begin
		      print'请先注册一个账户！'
		   end
		else
		   begin
		      if(select 金额 from 账户表 where 户号 = @户号) > @投保金额
			    begin
				  update 账户表
				  set 金额 = 金额 - @投保金额
				  where 户号 = @户号
		          insert into 缴费投保记录表(户号,投保名称,投保人姓名,投保人身份证号,到期时间,投保金额,投保备注)values(@户号,@投保名称,@投保人姓名,@投保人身份证号,@到期时间,@投保金额,@投保备注)
                 end
			  else
			    begin
				  print'您当前账户余额不足！！请尽快充值！'
				  rollback
			    end
		   end
	  end
end

exec createInsurance '201821121020','医疗保险','小红','35082219981112','2019-12-31',5000,'投保医疗保险'
select * from 缴费投保记录表
drop proc createInsurance 


go--存储过程赋权
create procedure sp_GrantProce(@username varchar(20))
as
begin
    declare @user varchar(20),@name varchar(40)
    declare t_cursor cursor for
    select user_name(uid) as users,name from sysobjects where (xtype='P' or xtype='X') and status>0
    
    open t_cursor
    
    fetch next from t_cursor into @user,@name
    
    while @@fetch_status=0
    begin
        exec('grant execute on '+@user+'.'+@name+' to '+@username)
        fetch next from t_cursor into @user,@name
    end
    
    close t_cursor
    deallocate t_cursor
end
go--权限赋予
create proc 管理员权限赋予
		@id varchar(20),
		@password varchar(20)
as
begin
declare @level int
if not exists(select * from 管理员 where @id = 工号)
	begin
		print'此账户不存在'
		return
	end
else if  not exists(select * from 管理员 where @id = 工号 and @password = 管理员密码)
	begin
		print'密码错误'
		return
	end
else
	begin
	exec sp_addlogin @id,@password
	exec sp_adduser @id,@id
	if((select 管理员级别 from 管理员 where @id = 工号) = 1)
		begin
			exec sp_addrolemember db_owner,@id
			print'一级权限赋权成功'
			return 
		end
	else if((select 管理员级别 from 管理员 where @id = 工号) = 2)
		begin
			exec sp_addrolemember db_datawriter,@id
			exec sp_GrantProce @id
			print'二级权限赋权成功'
			return
		end
			else if((select 管理员级别 from 管理员 where @id = 工号) = 3)
		begin
			exec sp_addrolemember db_datareader,@id
			print'三级权限赋权成功'
			return
		end
	end
end


select * from 管理员

exec 管理员权限赋予 '20168851159','gly007'
exec 管理员权限赋予 '20178859998','gly110'
 exec createAdmin '20178852998','gly110',3,'大亮','350822199110122165','13055851008','福建省厦门市云顶楼51号','3级管理员'
 drop proc 管理员权限赋予
go