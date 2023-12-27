import pymssql
from datetime import datetime

class plant:
 def __init__(self,user,password,identify):
  self.userName = user
  self.passWord = password
  self.identify = identify

 # 建⽴连接并获取cursor

 def select(self,cursor,conn,sqlNonQuery):
  # 查询记录
  s = cursor.execute(sqlNonQuery)
  if s is not None:
   print("error")
   return
  # 获取⼀条记录
  result = cursor.fetchone()
  n = 0
  # 打印记录
  while result:
   print(result)
   n=n+1
   result = cursor.fetchone()
  print("the count is",n)

 def add(self,user,cursor,conn):
  table_name = '园林植物基本信息管理业务'
  # 执行查询列名的 SQL 语句
  query = f"SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '{table_name}'"
  cursor.execute(query)
  columns = cursor.fetchall()
  column_names_str = '  '.join(column[0] for column in columns)
  print("please input your the data,use the space to separate")
  print(column_names_str)  # 打印一行列名
  id, species, family, alias, characteristics, points, value = map(str,input().split(' '))
  sqlNonQuery = "insert into 园林植物基本信息管理业务 values('%s','%s','%s','%s','%s','%s','%s')" % (id, species, family, alias, characteristics, points, value)
  cursor.execute(sqlNonQuery)
  conn.commit()
  sqlQuery = "select * from 园林植物基本信息管理业务"  # 查
  plant.select(self, cursor, conn, sqlQuery)

  table_name = '数据更新'
  query = f"SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '{table_name}'"
  cursor.execute(query)
  columns = cursor.fetchall()
  column_names_str = '  '.join(column[0] for column in columns)
  # 获取当前日期和时间
  current_datetime = datetime.now()
  # 提取年份、月份和日期并存储在变量中
  current_year = current_datetime.year
  current_month = current_datetime.month
  current_day = current_datetime.day
  # 将年月日存储在一个变量中
  current_date = f"{current_year}-{current_month:02d}-{current_day:02d}"
  updatetime = current_date
  createtime = current_date
  print(id, user, createtime, updatetime)
  sqlNonQuery = f"insert into {table_name} values('%s','%s','%s','%s')" % (id, user, createtime, updatetime)
  cursor.execute(sqlNonQuery)
  conn.commit()

  table_name = '园林植物分类管理'
  print("please input the genus")
  genus = input()
  print("please input the environ")
  environ = input()
  sqlNonQuery = f"insert into {table_name} values('%s','%s','%s','%s','%s','%s')" % (id, family, genus, species, alias, environ)
  cursor.execute(sqlNonQuery)
  conn.commit()


 def delete(self,cursor,conn):
  print("please input your the delete id of the data")
  id = int(input())
  sqlNonQuery = f"Delete From 园林植物基本信息管理业务 Where 编号 = '{ id }'"  # 删
  sqlQuery = "select * from 园林植物基本信息管理业务"  # 查
  s = cursor.execute(sqlNonQuery)
  if s is not None:
   print("error")
   return
  conn.commit() # 加上这条语句，利用python删除的元组才能从SQL Server去掉。

  sqlNonQuery = f"Delete From 数据更新 Where 编号 = '{id}'"  # 删
  s = cursor.execute(sqlNonQuery)
  if s is not None:
   print("error")
   return
  conn.commit()  # 加上这条语句，利用python删除的元组才能从SQL Server去掉。

  sqlNonQuery = f"Delete From 园林植物分类管理 Where 编号 = '{id}'"  # 删
  s = cursor.execute(sqlNonQuery)
  if s is not None:
   print("error")
   return
  conn.commit()  # 加上这条语句，利用python删除的元组才能从SQL Server去掉。




 def update(self,cursor,conn):
  print("please input your the update id of the data")
  id = int(input())
  print("please input your name of the line")
  line = input()
  print("please input your value")
  value = input()
  sqlNonQuery = f"UPDATE 园林植物基本信息管理业务 SET {line} = '{value}' WHERE 编号 = {id}"  # 改
  s = cursor.execute(sqlNonQuery)
  conn.commit() # 加上这条语句，利用python删除的元组才能从SQL Server去掉。
  if s is not None:
   print("error")
   return
  cursor.execute(sqlNonQuery)
  sqlQuery = "select * from 园林植物基本信息管理业务"  # 查
  plant.select(self,cursor,conn,sqlQuery)
  # 获取当前日期和时间
  current_datetime = datetime.now()

  # 提取年份、月份和日期并存储在变量中
  current_year = current_datetime.year
  current_month = current_datetime.month
  current_day = current_datetime.day

  # 将年月日存储在一个变量中
  current_date = f"{current_year}-{current_month:02d}-{current_day:02d}"
  updatetime = current_date

  table_name = "数据更新"
  sqlQuery = f"UPDATE {table_name} SET 更新时间 = '{updatetime}' WHERE 编号 = {id}"
  cursor.execute(sqlQuery)
  conn.commit()
  sqlQuery = "select * from 更新信息 "  # 查
  plant.select(self, cursor, conn, sqlQuery)


 def PlantCount(self,cursor,conn):
  print("please input your the select family of the data")
  family = input()
  sqlNonQuery = f"SELECT * FROM 园林植物基本信息管理业务 WHERE 科名 = '{family}'"
  plant.select(self,cursor,conn,sqlNonQuery)

 def InquirePlant(self,cursor,conn):
  print("please choose the num of the attribute(1 or 2):")
  k = int(input())
  if k == 1:
   print("please input your name of the line")
   line = input()
   print("please input your value of the line")
   value = input()
   sqlNonQuery = f"SELECT * FROM 园林植物基本信息管理业务 WHERE {line} = '{value}'"
   plant.select(self,cursor,conn,sqlNonQuery)
  elif k == 2:
   print("please input your name of the line")
   line1,line2 = map(str,input().split(' '))
   print("please input your value of the line")
   value1,value2 = map(str,input().split(' '))
   sqlNonQuery = f"SELECT * FROM 园林植物基本信息管理业务 WHERE {line1} = '{value1}' and {line2} = '{value2}'"
   plant.select(self,cursor, conn, sqlNonQuery)

 def InquireView(self,cursor,conn):
  sqlNonQuery = f"SELECT * FROM 不同科名的植物"
  plant.select(self,cursor, conn, sqlNonQuery)

 def findPlantWithAttribute(self, cursor, conn, attribute):
  table_name = '园林植物分类管理'
  # 执行查询列名的 SQL 语句
  query = f"SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '{table_name}'"
  cursor.execute(query)
  columns = cursor.fetchall()
  for column in columns:
   column_name_str = column[0]
   if column_name_str == attribute:
    print("please input the value of the attribute:")
    value = input()
    sqlQuery = f"select * from 园林植物基本信息管理业务 WHERE {attribute} = '{value}'"
    plant.select(self, cursor, conn, sqlQuery)
    return
  print("not find")
  return

 def findPlantWithEnviron(self,cursor,conn):
  print("please input the message of the environ")
  value = input()
  table_name = '园林植物分类管理'
  sqlQuery = f"select * from {table_name} WHERE 生长环境 LIKE '%{value}%'"
  plant.select(self, cursor, conn, sqlQuery)

 def menu(self,cursor,conn):
  flag = 1
  while flag:
   print("----------1.add the data--------------------")
   print("----------2.delete the data-----------------")
   print("----------3.update the data-----------------")
   print("----------4.select the data-----------------")
   print("----------5.select the family number--------")
   print("----------6.inquire the adapted plant-------")
   print("----------7.inquire the view----------------")
   print("----------8.find the plant with attribute---")
   print("----------9.find the plant with environ-----")
   print("----------10.quit the connect---------------")
   k = int(input("please input your demand num:(1 or 2 or 3 or 4 or 5)"))
   if k == 1:
    user = self.identify
    plant.add(self,user,cursor,conn)
   elif k == 2:
    plant.delete(self,cursor,conn)
   elif k == 3:
    plant.update(self,cursor,conn)
   elif k == 4:
    sqlNonQuery = "select * from 园林植物基本信息管理业务"
    plant.select(self,cursor,conn,sqlNonQuery)
   elif k == 5:
    plant.PlantCount(self,cursor,conn)
   elif k == 6:
    plant.InquirePlant(self,cursor, conn)
   elif k == 7:
    plant.InquireView(self,cursor, conn)
   elif k == 8:
    print("please input the attribute")
    attribute = input()
    plant.findPlantWithAttribute(self, cursor, conn, attribute)
   elif k == 9:
    plant.findPlantWithEnviron(self,cursor,conn)
   elif k == 10:
    conn.close()
    flag = 0
    print("already quit")


