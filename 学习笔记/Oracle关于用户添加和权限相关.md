oracle数据库的权限系统分为系统权限与对象权限。系统权限( database system privilege )可以让用户执行特定的命令集。例如，create table权限允许用户创建表，grant any privilege 权限允许用户授予任何系统权限。对象权限( database object privilege )可以让用户能够对各个对象进行某些操作。例如delete权限允许用户删除表或视图的行，select权限允许用户通过select从表、视图、序列(sequences)或快照(snapshots)中查询信息。

每个oracle用户都有一个名字和口令,并拥有一些由其创建的表、视图和其他资源。oracle角色(role)就是一组权限(privilege)(或者是每个用户根据其状态和条件所需的访问类型)。用户可以给角色授予或赋予指定的权限，然后将角色赋给相应的用户。一个用户也可以直接给其他用户授权。



Oracle的简单使用 参考Oracle的配置信息，简单添加一个用户用用户表空间



## 一、创建用户

oracle内部有两个建好的用户：system和sys。用户可直接登录到system用户以创建其他用户，因为system具有创建别 的用户的 权限。 在安装oracle时，用户或系统管理员首先可以为自己建立一个用户。

语法[创建用户]： create user 用户名 identified by 口令[即密码]；

例子： create user test identified by test;

语法[更改用户]: alter user 用户名 identified by 口令[改变的口令];

`例子： alter user test identified by 123456;`



## 二、删除用户

语法：drop user 用户名;

例子：drop user test;

若用户拥有对象，则不能直接删除，否则将返回一个错误值。指定关键字cascade,可删除用户所有的对象，然后再删除用户。

语法：  drop user 用户名 cascade;

例子：  drop user test cascade;

## 三、授权角色

oracle为兼容以前版本，提供三种标准角色（role）:connect/resource和dba.

（1）讲解三种标准角色：

1》. connect role(连接角色)

--临时用户，特指不需要建表的用户，通常只赋予他们connect role. 

--connect是使用oracle简单权限，这种权限只对其他用户的表有访问权限，包括select/insert/update和delete等。

--拥有connect role 的用户还能够创建表、视图、序列（sequence）、簇（cluster）、同义词(synonym)、回话（session）和其他  数据的链（link）



2》. resource role(资源角色)

--更可靠和正式的数据库用户可以授予resource role。

--resource提供给用户另外的权限以创建他们自己的表、序列、过程(procedure)、触发器(trigger)、索引(index)和簇(cluster)。



3》. dba role(数据库管理员角色)

--dba role拥有所有的系统权限

--包括无限制的空间限额和给其他用户授予各种权限的能力。system由dba用户拥有


（2）授权命令

语法： grant connect, resource to 用户名;

` 例子： grant connect, resource to test;`

   （3）撤销权限

  语法： revoke connect, resource from 用户名;

  列子： revoke connect, resource from test;

## 四、创建/授权/删除角色

除了前面讲到的三种系统角色----connect、resource和dba，用户还可以在oracle创建自己的role。用户创建的role可以由表或系统权限或两者的组合构成。为了创建role，用户必须具有create role系统权限。

1》创建角色

语法： create role 角色名;

例子： create role testRole;

2》授权角色

语法： grant select on class to 角色名;

列子： grant select on class to testRole;

注：现在，拥有testRole角色的所有用户都具有对class表的select查询权限

3》删除角色

语法： drop role 角色名;

例子： drop role testRole;

注：与testRole角色相关的权限将从数据库全部删除