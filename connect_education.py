import pymssql
# 建⽴连接并获取cursor
serverName = '127.0.0.1'
userName = 'shenna'
passWord = '20021010sn'
# database(str)：指定的是默认数据库，如果不需要的话，上述例⼦中其实可以不写。但是这样的话，那你的SQL语句中就得在最前⾯加上"USE tempdb ……"了，sql server⽤的多的应该知道怎么回事。
# as_dict(bool) ：如果设置为True，则后⾯的查询结果返回的是字典，关键字为查询结果的列名；否则(默认)返回的为list。
# autocommit(bool)：默认为False，这样如果对数据表进⾏更改，则需要⼿动调⽤commit来提交操作。
# port(str)：指定服务器的TCP端⼝，如果你没有改过的话使⽤默认的就好。#
conn = pymssql.connect(server = serverName,user = userName,password = passWord,database = "tempdb",charset = 'GBK')
cursor = conn.cursor()
# 创建测试表 persons，包含字段：ID、name、salesrep
cursor.execute("""
IF OBJECT_ID('persons', 'U') IS NOT NULL
 DROP TABLE persons
CREATE TABLE persons (
 id INT NOT NULL,
 name VARCHAR(100),
 salesrep VARCHAR(100),
 PRIMARY KEY(id))
""")
# 插⼊三条测试数据
cursor.executemany(
 "INSERT INTO persons VALUES (%d, %s, %s)",
 [(1, '陈博', 'John Doe'),
 (2, 'Jane Doe', 'Joe Dog'),
 (3, 'Mike T.', 'Sarah H.')])
# 如果连接时没有设置autocommit为True的话，必须主动调⽤commit() 来保存更改。
conn.commit()
# 查询记录
cursor.execute('SELECT * FROM persons WHERE salesrep=%s', 'John Doe')
# 获取⼀条记录
row = cursor.fetchone()
# 循环打印记录(这⾥只有⼀条，所以只打印出⼀条)
while row:
 print("ID=%d, Name=%s" % (row[0], row[1]))
 row = cursor.fetchone()
# 连接⽤完后记得关闭以释放资源
conn.close()

