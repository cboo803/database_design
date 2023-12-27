import pymssql
# 建⽴连接并获取cursor


class PestControlManager:
    def __init__(self, server_name, user_name, password, database):
        self.server_name = server_name
        self.user_name = user_name
        self.password = password
        self.database = database
        self.table_name = '病虫害'
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
        print("请输入病虫害的相关数据，对于包含空格的数据请使用引号包裹：")
        print("格式：病虫害编号 病虫害名称 植物编号 植物名称 药剂编号 药剂名称 '受灾时间' 受灾植物数量 受灾严重程度 '防治方法' 药剂用量 作用期限 创建人员 '创建时间'")
        data_str = input()

        import re
        pattern = re.compile(r'\'(.*?)\'|(\S+)')
        matches = pattern.findall(data_str)
        data = [match[0] or match[1] for match in matches]

        placeholders = ', '.join(['%s'] * len(data))
        sql_non_query = f"INSERT INTO {self.table_name} VALUES ({placeholders})"
        self.cursor.execute(sql_non_query, tuple(data))  # 将 data 转换为元组
        self.conn.commit()
        print("数据添加成功。")

    def delete_data(self):
        print("请输入需要删除的病虫害编号：")
        pest_id = input()
        sql_non_query = f"DELETE FROM {self.table_name} WHERE 病虫害编号 = %s"
        self.cursor.execute(sql_non_query, (pest_id,))
        self.conn.commit()
        print("数据删除成功。")

    def update_data(self):
        print("请输入需要更新的病虫害编号：")
        pest_id = input()
        print("请输入需要更新的属性名和新值，使用空格分隔：")
        print("示例：药剂名称 敌敌畏")
        line, value = input().split(' ')
        sql_non_query = f"UPDATE {self.table_name} SET {line} = %s WHERE 病虫害编号 = %s"
        self.cursor.execute(sql_non_query, (value, pest_id))
        self.conn.commit()
        print("数据更新成功。")

    def select_data(self):
        print("显示所有病虫害数据：")
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
    print("请输入数据库服务器地址（如127.0.0.1）：")
    server_name = input()
    print("请输入用户名：")
    user_name = input()
    print("请输入密码：")
    password = input()
    manager = PestControlManager(server_name, user_name, password, 'plant')
    manager.menu()
