import pymssql
import re
# 建⽴连接并获取cursor

class GardenMaintenanceManager:
    def __init__(self, server_name, user_name, password, database):
        self.server_name = server_name
        self.user_name = user_name
        self.password = password
        self.database = database
        self.table_name = '养护任务'
        self.conn = None
        self.cursor = None

    def connect(self):
        self.conn = pymssql.connect(server=self.server_name, user=self.user_name, password=self.password, database=self.database)
        self.cursor = self.conn.cursor()

    def close_connection(self):
        if self.cursor:
            self.cursor.close()
        if self.conn:
            self.conn.close()

    def add_data(self):
        print("请输入养护任务的相关数据，对于包含空格的数据请使用引号包裹：")
        print("格式：任务名称 '执行时间' 执行地点 执行人员 任务描述 养护对象 创建人员 '创建时间' '更新时间' 病虫害编号")
        data_str = input()

        pattern = re.compile(r'\'(.*?)\'|(\S+)')
        matches = pattern.findall(data_str)
        data = [match[0] or match[1] for match in matches]

    # 获取手动输入的病虫害编号，假设它是最后一个输入值，同时将其作为养护任务编号
        pest_id = data[-1]
    # 由于养护任务编号和病虫害编号相同，这里我们需要构造一个包含所有值的数据列表
    # 其中养护任务编号（即pest_id）在列表的第一个位置
        data_with_ids = [pest_id] + data
 
    # 定义所有的列名（包括养护任务编号和病虫害编号）
        columns = "养护任务编号, 任务名称, 执行时间, 执行地点, 执行人员, 任务描述, 养护对象, 创建人员, 创建时间, 更新时间, 病虫害编号"
        placeholders = ', '.join(['%s'] * (len(data_with_ids)))
 
        sql_non_query = f"INSERT INTO {self.table_name} ({columns}) VALUES ({placeholders})"
    # 执行SQL语句时，传入包含所有值的数据列表
        self.cursor.execute(sql_non_query, tuple(data_with_ids))
        self.conn.commit()
        print("数据添加成功。")




    def delete_data(self):
        print("请输入需要删除的养护任务编号：")
        task_id = input()
        sql_non_query = f"DELETE FROM {self.table_name} WHERE 养护任务编号 = %s"
        self.cursor.execute(sql_non_query, (task_id,))
        self.conn.commit()
        print("数据删除成功。")

    def update_data(self):
        print("请输入需要更新的养护任务编号：")
        task_id = input()
        print("请输入需要更新的属性名和新值，使用空格分隔：")
        print("示例：执行人员 张三")
        column_name, value = input().split(' ', 1)
        sql_non_query = f"UPDATE {self.table_name} SET {column_name} = %s WHERE 养护任务编号 = %s"
        self.cursor.execute(sql_non_query, (value, task_id))
        self.conn.commit()
        print("数据更新成功。")

    def select_data(self):
        print("显示所有养护任务数据：")
        sql_query = f"SELECT * FROM {self.table_name}"
        self.cursor.execute(sql_query)
        results = self.cursor.fetchall()
        for row in results:
            print(row)
        print("数据查询完成。")

    def menu(self):
        self.connect()
        flag = True
        while flag:
            print("----------1.添加数据--------------------")
            print("----------2.删除数据-----------------")
            print("----------3.更新数据-----------------")
            print("----------4.查询数据-----------------")
            print("----------10.退出连接---------------")
            k = int(input("请输入您的需求编号（1，2，3，4或10）："))
            if k == 1:
                self.add_data()
            elif k == 2:
                self.delete_data()
            elif k == 3:
                self.update_data()
            elif k == 4:
                self.select_data()
            elif k == 10:
                flag = False
                print("已退出。")
            else:
                print("输入的编号不正确，请重新输入！")
        self.close_connection()

if __name__ == "__main__":
    server_name = input("请输入数据库服务器地址（如127.0.0.1）：")
    user_name = input("请输入用户名：")
    password = input("请输入密码：")
    database = input("请输入数据库名称：")
    manager = GardenMaintenanceManager(server_name, user_name, password, database)
    manager.menu()
