import pymssql
from datetime import datetime
# 连接数据库

#Server is listening on [ 127.0.0.1 <ipv4> 49899] accept sockets 1.
# 创建游标


def show_indicators(cursor,conn):
    try:
        # 查询监测指标表中的所有指标
        cursor.execute("SELECT 指标编号, 指标名 FROM 监测指标")
        indicators = cursor.fetchall()

        print("监测指标表：")
        for indicator in indicators:
            print(f"{indicator[0]}. {indicator[1]}")

        return indicators
    except Exception as e:
        print(f"发生错误：{e}")
        return None

def calculate_average(indicator_id,cursor,conn):
    try:
        # 查询拥有指定指标编号的监测记录表中的记录
        cursor.execute(f"SELECT * FROM 监测记录表 WHERE 指标编号 = {indicator_id}")
        records = cursor.fetchall()

        if records:
            # 查询监测指标表中的指标名
            cursor.execute(f"SELECT 指标名 FROM 监测指标 WHERE 指标编号 = {indicator_id}")
            indicator_name = cursor.fetchone()[0]

            # 计算平均值
            values = [record[9] for record in records]  # 这里的9是指标参数在记录表中的索引
            average_value = sum(values) / len(values)

            print(f"{indicator_name}的平均值：{average_value}")

        else:
            print("没有找到对应的监测记录。")

    except Exception as e:
        print(f"发生错误：{e}")

def calculate_maximum(indicator_id,cursor,conn):
    try:
        # 查询拥有指定指标编号的监测记录表中的记录
        cursor.execute(f"SELECT * FROM 监测记录表 WHERE 指标编号 = {indicator_id}")
        records = cursor.fetchall()

        if records:
            # 查询监测指标表中的指标名
            cursor.execute(f"SELECT 指标名 FROM 监测指标 WHERE 指标编号 = {indicator_id}")
            indicator_name = cursor.fetchone()[0]

            # 计算最大值
            values = [record[9] for record in records]  # 这里的9是指标参数在记录表中的索引
            max_value = max(values)

            print(f"{indicator_name}的最大值：{max_value}")

        else:
            print("没有找到对应的监测记录。")

    except Exception as e:
        print(f"发生错误：{e}")

def show_plants_and_locations(indicator_id,cursor,conn):
    try:
        # 查询对象指标表中的对象编号和指标编号
        cursor.execute(f"SELECT 对象编号 FROM 对象指标 WHERE 指标编号 = {indicator_id}")
        object_ids = cursor.fetchall()

        # 查询监测对象表中的植物名称、监测地点和指标名称
        plants_and_locations = []
        for object_id in object_ids:
            cursor.execute(f"""
                SELECT 监测对象.植物名称, 监测对象.监测地点, 监测指标.指标名
                FROM 监测对象
                JOIN 监测指标 ON 监测对象.对象编号 = {object_id[0]} AND 监测指标.指标编号 = {indicator_id}
            """)
            plant_location_indicator = cursor.fetchone()
            plants_and_locations.append(plant_location_indicator)

        # 查询监测记录表中的指标参数
        cursor.execute(f"SELECT 指标参数 FROM 监测记录表 WHERE 指标编号 = {indicator_id}")
        indicator_parameters = cursor.fetchall()

        # 输出结果
        print("拥有该指标编号的全部植物名称、监测地点、指标名和指标参数：")
        for i in range(len(plants_and_locations)):
            plant_name, location, indicator_name = plants_and_locations[i]
            indicator_parameter = indicator_parameters[i][0]
            print(f"{i+1}. 植物名称: {plant_name}, 监测地点: {location}, 指标名: {indicator_name}, 指标参数: {indicator_parameter}")

    except Exception as e:
        print(f"发生错误：{e}")

def show_all_records(cursor,conn):
    try:
        # 查询整个监测记录表的列名
        cursor.execute("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '监测记录表'")
        column_names = cursor.fetchall()
        column_names = [column[0] for column in column_names]

        # 查询整个监测记录表的数据
        cursor.execute("SELECT * FROM 监测记录表")
        records = cursor.fetchall()

        # 输出列名
    
        print("\t".join(column_names))

        # 输出数据

        for record in records:
            print("\t".join(str(item) for item in record))

    except Exception as e:
        print(f"发生错误：{e}")

def insert_data(table_name, values,cursor,conn):
    try:
        values_tuple = tuple(values)
        placeholders = ', '.join(['%s'] * len(values_tuple))
        cursor.execute(f"INSERT INTO {table_name} VALUES ({placeholders})", values_tuple)
        conn.commit()
        print("数据添加成功！")
    except Exception as e:
        print(f"数据添加失败：{e}")

def update_data(table_name, set_clause, where_clause,cursor,conn):
    try:
        cursor.execute(f"UPDATE {table_name} SET {set_clause} WHERE {where_clause}")
        conn.commit()
        print("数据更新成功！")
    except Exception as e:
        print(f"数据更新失败：{e}")

def delete_data(table_name, where_clause,cursor,conn):
    try:
        cursor.execute(f"DELETE FROM {table_name} WHERE {where_clause}")
        conn.commit()
        print("数据删除成功！")
    except Exception as e:
        print(f"数据删除失败：{e}")

def query_data(table_name,cursor,conn):
    try:
        cursor.execute(f"SELECT * FROM {table_name}")
        rows = cursor.fetchall()
        for row in rows:
            print(row)
    except Exception as e:
        print(f"查询失败：{e}")

def data_monitoring_mode(cursor,conn):
    object_id = input("请输入监测对象编号：")
    try:
        # 从监测对象表中提取对象信息
        cursor.execute(f"SELECT 植物名称, 监测地点 FROM 监测对象 WHERE 对象编号 = {object_id}")
        object_info = cursor.fetchone()

        if object_info:
            plant_name, monitoring_location = object_info
            print(f"监测对象信息：植物名称: {plant_name}, 监测地点: {monitoring_location}")

            personnel_id = input("请输入监测人员编号：")

            # 展示监测指标表中的所有指标和指标编号
            cursor.execute("SELECT 指标编号, 指标名 FROM 监测指标")
            indicators = cursor.fetchall()

            print("监测指标表：")
            for indicator in indicators:
                print(f"{indicator[0]}. {indicator[1]}")

            # 输入感兴趣的指标编号

            selected_indicator_id = input("请输入指标编号：")
            indicator_parameter = input("请输入指标参数：")

            # 读取设备编号
            cursor.execute(f"SELECT 设备编号 FROM 对象设备 WHERE 对象编号 = {object_id}")
            device_id = cursor.fetchone()[0]
            
            # 生成监测记录
            current_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            cursor.execute("""
                INSERT INTO 监测记录表 
                (监测时间, 创建时间, 更新时间, 监测地点, 人员编号, 设备编号, 对象编号, 指标编号, 指标参数) 
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, (current_time, current_time, current_time, monitoring_location, personnel_id, device_id, object_id, selected_indicator_id, indicator_parameter))

            conn.commit()
            print("监测记录生成成功！")

        else:
            print("监测对象不存在。")

    except Exception as e:
        print(f"发生错误：{e}")
def show_exception_records(cursor,conn):
    try:
        cursor.execute("SELECT * FROM 监测记录表 WHERE 是否异常 = '是'")
        exception_records = cursor.fetchall()

        if exception_records:
            print("监测记录表中异常的信息：")
            for record in exception_records:
                print(record)
        else:
            print("没有找到异常记录。")

    except Exception as e:
        print(f"发生错误：{e}")   

def caidan_bad():
    print("发现op开始猎杀")
    print("                                                                                        ")
    print("                                .+aaazaaaaaaaaaaaaaaazu~+.                               ")
    print("                        .^aaaaaaazzazzzzzzzzzzzzzzzzaaaaaaaa-                         ") 
    print("                      .ouuaaaaaazzzzzzzzzvvvvvzvvvvzzzzzzzzzaaaaau-                     ") 
    print("                    .zaaaaaaazzzzzvvvvvvvnnnnnnvvvvvvvvvvzzzzzzzaaaaaa^                  ") 
    print("                   ~aaaaaaazzzzvvvvnnnnnnnnnonnnnnnnnnnnnnvvvvvzzzzzaaaaa1.               ") 
    print("               .zuaaaazzzzzvvnnnnnooooooooooooooooooooooonnnnnvvvzzzzzaaaaa+             ") 
    print("              zuaaaaazzzvvvnnnnnooooooo~~~~~~~~~~~~~~oooooooonnnvvvvzzzzzaaaa.           ") 
    print("             ^aaaaazzzzvvvnnnnooooo~~~~~~~~~~~~~~~~~~~~~~~oooooonnnnvvvzzzzaaaan          ") 
    print("             vaaaazzzzvvnnnnoooooo~~~~~~~~;;;;;;;~~~~~~~~~~~~~~ooooonnnvvvzzzaaaaz.        ") 
    print("         .zuuaaazzzvvnnnooooo~~~~~~~;;;;;;;;;;;;;;;;;;;;~~~~~~~~oooonnnvvzzzaaaa1-       ") 
    print("         .aaaaazzzzvnnoooooo~~~~~~;;;;;;;;;;;;;;;;;;;;;;;;;;~~~~~~ooooonnnvvzzaaaaa-      ") 
    print("        1uaaaazzvvnnnoooo~~~~~~;;;;;;;;;;;;;*****;;;;;;;;;;;;;~~~~~oooonnnvvzzaaaau.     ") 
    print("       zauaazzzvvnnnooo~~~~~;;;;;;;;;;;****************;;;;;;;;~~~~~oooonnnvvzzaaaa1     ") 
    print("      -uuaazzzvvnnooooo~~~;;;;;;;***;**********************;;;;;;~~~~ooooonnvzzzaaau^    ") 
    print("      zuaazzzvvnnoooo~~~~~;;;;;*;;************************;;;;;;;;~~~~oooonnvvzzzaaai    ") 
    print("     .uuaazzzvvnnoooo~~~~;;;;;;;;*************************;;;;;;;;~;~~~oooonnvzzzzaau^   ") 
    print("     ^uaaazzvvnnoooo~~~~~;;;;;;******************************;;;;;;;~~~oooonnvvzzzaaui   ") 
    print("     ouaazzzvvnnoooo~~~;;;;*6********************************o;;6;;;~~~~ooonnnvzzzzaa1   ") 
    print("     uaaazzzvnnnooo~~~~~;;8&&&&$$8^************************8$$$$&$6;~~~~ooonnnvvzzzaa!   ") 
    print("     uaaaazzznnnooo~~~~~;;;~$$&$$$$&8^*****************~$&&&&$$&$;;;~~~~ooonnnvzzzzau1. ")  
    print("     aaaazzzvnnnooo~~~~~;;;;;;*o$$$$$$$%+***********^8&&&&&&$;**;;;;~~~~ooonnnvvzzaau1  ")  
    print("     *aaazzzvvnno!~~~~~~;;;;;;*%8ii8$$$$$8~*******;$&&$uii%$$8o;;;;~~~~~~;nznnvzzzaau6  ")  
    print("     +aaaazzvvvo$&&n~~~~~;;;;*$$!ii8$$$$$$^********$&&%!ii$$$$$~;;;~~~~~3$$%nvvzzzaai!  ")  
    print("      zaaazzzvvna&&$6~~~~~;;;;$&$$$$$&&$+**********^1$$$$$$$$$$;;;;~~~~6$$$~nvvzzzzu1-  ")  
    print("      ;aaaazzzvvn~%$$%n~~~;;;~8&$$$$$&&%^************$$$&$$$$&$;;;~~~o8$$%nnvvzzzza1i   ")  
    print("      .aaaaazzvvnnv$&$$z~~~~;;;1&$$$$8$^*************^$&$&$$&a*;;;~~n1ua%onnvzzzza11-   ")  
    print("       ^uaaazzzvvnnn8$$$$;;~;;;;;;;;*******************;;;;;;;;~~~nu1uaaaavvvzzaaui!    ")  
    print("        aaaaazzzvvvnno%$$$&u;~;;;;;;;;;;;;;;*******;;;;;;;;~~~~~z11uuaaaaaaaaaaauu1     ")  
    print("         vaaaazzzvvnnno~$$$$&$*;;;;;;;;;;;;;;;;;;;;;;;;;;;;~~n31iuuaaaaaaaaaaaa11i.     ")  
    print("          naaaazzzzvvnnooo$&&&$$$%~~;;;;;;;;;;;;;;;;;;;;~o111ii!1uuaaaaaaaaaaaa1!       ")  
    print("          +uaaaazzzvvvnnnoo~&&$$$$$$&$%o~*;;;;*~;~nu1111111uuu1i11uaaaaaaaaaaau-        ") 
    print("             1uaaaazzzvvvnnoooo~o$$$$$$$$$$$$$$$$$3111111uuuuuuuu111uuaaaaaaaaaai       ")  
    print("              +1aaazzzzzvvvnnnoooooooz~%%$$$$$$$&&&%auuaaaaaaaaaaauuuaaaaaaaaaaaz       ")  
    print("                -zaaaazzzzzvvvvnnnnnnoooooooooooooooonzaaaaaaaaaaaaaaaaaaaaaaaaa^       ")  
    print("                  .uuuaaaazzzzzzvvvvvnnnnnnnnnnnnnnnnnvvzaaaaaaaaaaaaaaaaaaaaaau        ")  
    print("                     .11uaaazzzzzzzzvvvvvvvvvvvvvvvvvvzvzaaaaaaaaaaaaaaaaaaaaan         ")  
    print("                         ^1i1uaaazzzzzzzzzzzzzzzzzzzzzzzzzauaaaaaaaaaaaaaaaaa           ")  
    print("                             -nuuiuuuuaaaaaaaaaaaaau111111i3a+zaaaaaaaaaaa+             ")  
    print("                                    .^*i1iii1uuu!ii1u-..          ---..                 ")  

def caidan_ok():
    print("伟大，无需多言")                                                                                  
    print("&&##&&#&&&&&####&&&$$$$$&&&$&&$&&&&&&&&&&&&&##&&&&#&#&&&&&###&&&&&&&&&&&&$$$$$&&$$&&$$$&&&&######&&&")
    print("zzaaaaaazzzzzzzznvazzzzzzzzzzzzauui!688888%%88%888%%%%%%%$%%%$%%8866!ii1uuaaazzaaauuaaauaauuuuuuuuuu")
    print("zzaaazzzzzzzzzzznvazvzvzzzu1!666iavvu8$6!!!!33!iuzui!36886333333666888%%$86iiuuaaaaaaauuuuuauuuuuuuu")
    print("zzzzzzzzzzzzzzaznvzazza1i8%%6un;^^^++n68ii!un;^++++++++*v363i!iiii!!!!!!333688883iuaaaaaaauuuuuuuuuu")
    print("zzzzzzzzzzzzzzzznna1i66888iz;^^^+++++o!81n~^+++++---+----*a6311iiiiiiiiii!!!!33688%83!uaaaaaaaaauuua")
    print("zzzzzzzzzzzzzzzau!686666in;^^^^++++++n!1;-+-+------+------~i8iuiiiiiiiii!!!!!!!!!!33%%83iuaaaaaaauuu")
    print("zzzzzzzzzzzzzu!88833663a;^^+++++++++o11o+----------------.*i6iuiii1iiiii!ii!ii!!!!!!!338%83iazaaaaau")
    print("zzzzzzzzzzz13863!!!66iv*^^++^;;^+++~1!z^..----------------;i6i1iiiiiiiiiiii!!!!!!!!!!!!!368%8!uaaaaa")
    print("zzzzzzzzzu38%3!!!!66!n*++++-;aaonvnz!u~;~+.^on;----------+v361uiiiiii!ii!i!!!!!!!!!!!!!!!!!38$$6iaaa")
    print("zzazzzzai686!!!!!3881;-+++++-^~ooz13!n^~vnnzz~^---------+~16!u1iiiiiii!!i!!!!i!!!!!!!!!!!!!!33%$$6iu")
    print("aaaaza16%6!!!!!338%81~++^+*ovu1!3iu13u*-*;^^+++++---+---*a68!!!3!!!!ii!!!!!!!!!!!!!!!!!!!!3!!!368$$6")
    print("i!!!i6%%63!!!366!zvu!avzaiiii!!!3336%3n++++++++++++----oz1n^+*ovu!363!!i!!!!!!!!!!!!!3333!!33!!!36%&")
    print("zaa16$$%866663un;^+++^~u3!1iiiiii!i6$%1n*++++++++++++*zua~+-----+-+;vi333iiiiii!!!!!!!!!!!!!3!!!3338")
    print("za16%83336861azn*^^+++*u3!11iiuv*^oi6ivz1uvn~;;;**~naav;^----+--------+~u!3!iiii!i!i!!!!!!!!!!!!!!!3")
    print("a1386!!!33u~*^^~o;*+--^v3!11iiuv*+oi3v^--^*;~oo~~~~;+++++++-+++----------+o1!!!i!!!333!i!i!!!!!!!!!3")
    print("16%83!36!v;++++++++----^n1i!!ii!ii1ao+-------------++--+^*;~onvvaauuauuuuazazzu3%863333!!i!iii!!!!!3")
    print("8%8!i331o+++++++++++------vi!v~oo;++-.---------------.-*vvnno~;;***^^++--------+o!3!i1iiiiiii!!i!!!!")
    print("$$6366!zooo~~*++++++-----^v1v+..-.---.-..-.----------------------------.--.-------ni3!111iii!!!!!!!!")
    print("&6383z~^*^***^^+++++----+n1z^.-.-..---.....-...----------------------------..------^n!3i1111iiiiii!!")
    print("%!36u;---++-++++--------*11; .-..-----...--------.------------------------.----------~u3ii11iiiii!!!")
    print("636!o+-+-+-++++---------niv+.....-.-----------.-----.-*vaaazaazzzv~~;*^^++++----------+a6!11iiiiiii!")
    print("33!v++^+++++++++-----+-*11;....-..------------.-----.-----++++^**;~ovzzaaazzvvn~;*^^^+-;u6!i1iii!!!!")
    print("63u;^*;;~oo~o;^+-------~1u^ ------.------------.----------....+--------------+^^*onnnvvva363iiiiiii!")
    print("%!zoooo~;^++++---.----+viv- +--------.--..------------+**^----------------------------+-.n33i1iiiii!")
    print("3u*-++++++--++--------+aio..^---------....-------------;nzaav~*+------------------------.^16!1iiiiii")
    print("!o--++++++--+++------.^ui~ .--------------------------------+~nzazo;+---.-.---------------z63u11i1ii")
    print("u;-++++-++--+---------^u!o -------------.--------++++------------^~vazn;^----.------------o38i1iiiii")
    print("z+-^++-++----++------.+aio ------.--...-..-----------------------+---+*~nvv~;^+---+-------;!811iiiii")
    print("z+-+++++---+++-------.+z!n..+----.-.--------------+-----------+------------^~nnvo;^+------;i8iuiiiii")
    print("z--+++++--+++---------+z!v-.----------------------+------------.-------.-------+^;ovo*----*i%iuiiiii")
    print("z^.++++++---++--+---+^*ziz~~ooo;**++---+------------+--+---------------------------+-+----;!8iuiiiii")
    print("i;-+^++++++---+*~nvvvo;**^^+^***;~onnnnnn~~~*+++---------------------++++-----.-----------~381uiiiii")
    print("6a^-++++++^*;onn;^--+-+------------------++^;~nvvvn~^++-----+-----------+---------.------+v6611iiiii")
    print("83v^++^^;onn;^+++---..------------.------.-.-+----++~vzzvn~~*++---------..---------------*u8311iiii!")
    print("38!v*^ovo*+++---------------++--...----------------------^*~nzzn;^++---------------------~!6iu1iiii!")
    print("ai6!v*~*+++-----------------+-----.-----------------...--------^*;nvzo*^-----+-..-.-----^a6611iiiii!")
    print("aai63z;+++++--++--.-..-----------------------.-.-......--...-...---.-+*ovvn~^+----+-+---o66i1iiiii!!")
    print("zzzi83a~+++++-+------------------------------.-.-.------------...--...----^^~*+---+--+-~u3311iiiiii!")
    print("azzz136io+--++++-++-----++----+---.--..--------------.---------..----....-.---.------^n!3iiiiiiii!!3")
    print("aazzaau63u~++-+------------------------------.-----------+-+------.-----------------*a!!iiiiiiii!!68")
    print("aaaaaazzi63a~+--+--+++------------------------------------------------------------^ni!iiiiiiiii!388!")
    print("aaaaazzzza!68u;++++++++++*****++--------..--------------------------------------^ni!iiiiiiii!!3883uz")
    print("aaaaaaazzza!$$$63666333363333333!!uzo~~~;~~;^--+-+---------------------------+*v!!iiiiiiii!!6683iznn")
    print("aazaaazzai388%%$&863!!!!!!333333333336%81nni633iii!!iiiiiii1uaavvno~~;**^*;~z3363!!!ii!!!3688!uznvvn")
    print("aaaaazza!%833363!!!!!!!!!!!!!!!!!!!!!!!63uo*o!6333!!!!!!3!!!366666666886668%$$$%%$%%%%%%&&$!avvvvvvv")
    print("zzzzzzzi8%3!!!!!!i!!!!!!!!!!!!!!!!!!!!!3686!ai8%8888888666666666888%%%%%%8%%%%%%%%%%%%%%$&$!zvvvvvvv")
    print("zazzzzu3$6ii!!!&%8&@%83!!!!@#$!!!!!!!66%%%8%$##&&&&$8$$&&&&&$$883&%&%%$&88%$$#8866666686%$$!znvvzzvv")
    print("zzzazz18$!ii!!%  +     &%%%u $%%8$68$%%333!&aa^.aaa$%        $  ^*~;  &8         !333!333%$6znvvvvzv")
    print("aazzzza8$3!ii8    -   -$%%$. $&$$#  #  $  &         #%.   . %$     +3&&!388888868!3!!!!!!8$6anvzvvzv")
    print("aazzazz18%63!!v .    . &!%. + &~^#%&8&%%$%$i$  . & %3$8$ 3%%8$n . $#  -6;       $!!3!!!!!8$8anvavvvv")
    print("aaazazzza6%6!3$  6& @ ^8 + #+$. +*------*z&. ^%    .$ .  ; - @     a%!!!*       #!3!!!!!38$6anvvvvzv")
    print("aaaaaazzu66z^-+++***-+^^.^+---+-++--+-----+*~ai!!ii1!1!!i!ii!!6!!!!!!!!!!3!!33!!!!!3!!ii1%$6vnzvvvvv")                                                                                


def advanced_menu(cursor,conn):
    while True:
        print("高级选项菜单:")
        print("1. 返回主菜单")
        print("2. 数据监测模式")
        print("3. 显示监测指标表中的所有指标")
        print("4. 计算指定指标的平均值")
        print("5. 计算指定指标的最大值")
        print("6. 显示拥有指定指标的植物名称、监测地点和指标参数")
        print("7. 显示整个监测记录表")
        print("8. 显示异常监测记录信息")
        

        choice = input("请选择功能（输入对应数字）：")

        if choice == '1':
            custom_sql_query = input("请输入自定义 SQL 查询语句：")
            try:
                cursor.execute(custom_sql_query)
                rows = cursor.fetchall()
                for row in rows:
                    print(row)
            except Exception as e:
                print(f"查询失败：{e}")

        elif choice == '2':
            data_monitoring_mode(cursor,conn)    

        elif choice == '3':
            show_indicators(cursor,conn)

        elif choice == '4':
            indicator_id = input("请输入指标编号：")
            calculate_average(indicator_id,cursor,conn)

        elif choice == '5':
            indicator_id = input("请输入指标编号：")
            calculate_maximum(indicator_id,cursor,conn)

        elif choice == '6':
            indicator_id = input("请输入指标编号：")
            show_plants_and_locations(indicator_id,cursor,conn)

        elif choice == '7':
            show_all_records(cursor,conn)
        elif choice == '8':
            show_exception_records(cursor,conn)

        elif choice == '1':
            break
def menu(cursor,conn):
    while True:
        print("1. 增加数据\n2. 修改数据\n3. 删除数据\n4. 查询数据\n5. 高级选项 \n0. 退出")
        choice = input("请选择功能（输入对应数字）：")

        if choice == '1':  # 增加数据
            table_name = input("请输入要操作的表名：")
            values = input("请输入要添加的数据，以逗号分隔：").split(',')
            insert_data(table_name, values,cursor,conn)

        elif choice == '2':  # 修改数据
            table_name = input("请输入要操作的表名：")
            set_clause = input("请输入 SET 子句，如列1=值1, 列2=值2：")
            where_clause = input("请输入 WHERE 子句，如列3='条件'：")
            update_data(table_name, set_clause, where_clause,cursor,conn)

        elif choice == '3':  # 删除数据
            table_name = input("请输入要操作的表名：")
            where_clause = input("请输入 WHERE 子句，如列1='条件1' AND 列2='条件2'：")
            delete_data(table_name, where_clause,cursor,conn)

        elif choice == '4':  # 查询数据
            table_name = input("请输入要操作的表名：")
            query_data(table_name,cursor,conn)

        elif choice == '5':  # 进入高级选项
            access_code = input("请输入验证代码（输入 'op'）：")
            if access_code.lower() == 'op':
                caidan_bad()
                print("验证失败，返回基础菜单")
            elif access_code.lower() == 'dave':
                caidan_ok()
                print("crrraaazzzzzzzzzzzzzzzzzzy diiiiiiiiiiiiiiiiiiiiiiiiive")
                print("Welcome Back,I have always missed you very much")
                advanced_menu()
            else:
                print("验证失败，返回基础菜单")

        elif choice == '0':  # 退出
            break



