import pymssql
import connect_plant
import check
import maintenance
def connect(serverName, userName, passWord):
    # database(str)：指定的是默认数据库，如果不需要的话，上述例⼦中其实可以不写。但是这样的话，那你的SQL语句中就得在最前⾯加上"USE tempdb ……"了，sql server⽤的多的应该知道怎么回事。
    # as_dict(bool)：如果设置为True，则后⾯的查询结果返回的是字典，关键字为查询结果的列名；否则(默认)返回的为list。
    # autocommit(bool)：默认为False，这样如果对数据表进⾏更改，则需要⼿动调⽤commit来提交操作。
    # port(str)：指定服务器的TCP端⼝，如果你没有改过的话使⽤默认的就好。
    conn = pymssql.connect(server=serverName, user=userName, password=passWord, database="plant", charset='utf8')
    cursor = conn.cursor()
    print("connect the database of 园林植物基本信息管理业务")
    return cursor, conn

def login():
    print("please input your username")
    user = input()
    print("please input your password")
    password = input()
    table_name = "用户"
    query = f"select * from {table_name}"
    cursor.execute(query)
    aa = cursor.fetchall()
    for a,b,c in aa:
        if a == user:
            if b == password:
                if c == '系统管理员':
                    print(c,",welcome to the database")
                    return a,b,c
                elif c == '养护人员':
                    print(c,",welcome to the database")
                    return a,b,c
                elif c == '监测人员':
                    print(c,",welcome to the database")
                    return a,b,c
                elif c == '上级主管':
                    print(c,",welcome to the database")
                    return a,b,c



if __name__ == "__main__":
    serverName = '127.0.0.1'
    userName = "cboo"
    passWord = "cbo512528"
    cursor, conn = connect(serverName, userName, passWord)
    while 1:
        user,password,identify = login()
        if identify == '系统管理员':
            plant = connect_plant.plant(user,password,identify)
            plant.menu(cursor,conn)
            # classify = plant_manager.classify(plant)
        if identify == '养护人员':
            manager = maintenance.GardenMaintenanceManager(cursor,conn)
            manager.menu()
        if identify == '监测人员':
            check.menu(cursor,conn)
    # plant.menu(cursor, conn)