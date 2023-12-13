from datetime import datetime
import mysql.connector
from flask import Flask, render_template, request

bd = [["assddsdsd0", "a1", "A001", "7:55", "12:10", "10.12.22"], ["b0", "b1", "B001", "7:55", "12:10", "10.12.22"],
      ["c0", "c1", "C001", "7:55", "12:10", "10.12.22"], ["d0", "d1", "D001", "7:55", "12:10", "10.12.22"]]

bd_by_station = []

bd_by_from_to = []

bd_by_number = []

bd_way = [["station1", "12.15", "1ч10м", "10.12.2022"], ["station2", "12.15", "1ч10м", "10.12.2022"],
          ["station3", "12.15", "1ч10м", "10.12.2022"]]


app = Flask(__name__)

cnx = mysql.connector.connect(
    host="localhost",
    port=3306,
    user="root",
    password="123",
    database="trains2")
cur = cnx.cursor()
limited_trip = "SELECT * FROM trip LIMIT 4"
# from_to = 'SELECT trip.train_number, trip.number_of_cars FROM trip  \
#     RIGHT OUTER JOIN ( \
#         SELECT  train_number,  route_id,  count(*) AS c FROM  route \
#         WHERE  station_name = "Борисоглебск"  OR station_name = "Жердевка" \
#         GROUP BY train_number HAVING c > 1 \
#         ) all_trains_between_stations ON trip.train_number = all_trains_between_stations.train_number'
cur.execute(limited_trip)
result = cur.fetchall()
i = 0
for row in result:
    bd[i][0] = row[4]
    bd[i][1] = row[3]
    bd[i][2] = row[1]
    i = i + 1


@app.route('/')
def index():
    date_ = request.args.get("date_")

    from_ = request.args.get("from_")
    to_ = request.args.get("to_")
    if from_:
        from_ = from_.strip()
    if to_:
        to_ = to_.strip()
    if date_:
        date_ = date_.strip()
    bd_by_from_to.clear()
    if (from_ and to_):
        if (date_):
            from_to = f'\r\nSELECT * FROM trip JOIN (\r\nSELECT tmp1.trip_id, tmp1.train_number  FROM (\r\nSELECT * FROM route WHERE trip_id IN (\r\n  SELECT trip_id\r\n            FROM \r\n              route \r\n            WHERE \r\n              station_name LIKE \"%{from_}%\" \r\n              OR station_name LIKE \"%{to_}%\" \r\n            GROUP BY \r\n              train_number \r\n            HAVING \r\n              COUNT(*) > 1\r\n) AND station_name LIKE \"%{from_}%\" \r\n  OR station_name LIKE \"%{to_}%\" \r\n ORDER BY trip_id, arrival_time ) tmp1 JOIN \r\n(\r\nSELECT * FROM route WHERE trip_id IN (\r\n  SELECT trip_id\r\n            FROM \r\n              route \r\n            WHERE \r\n              station_name LIKE \"%{from_}%\" \r\n              OR station_name LIKE \"%{to_}%\" \r\n            GROUP BY \r\n              train_number \r\n            HAVING \r\n              COUNT(*) > 1\r\n) AND station_name LIKE \"%{from_}%\" \r\n  OR station_name LIKE \"%{to_}%\" \r\n ORDER BY trip_id, arrival_time DESC) tmp2 ON tmp1.station_name LIKE \"%{from_}%\" and tmp2.station_name LIKE \"%{to_}%\" AND tmp1.trip_id = tmp2.trip_id\r\n WHERE timediff(tmp2.arrival_time, tmp1.arrival_time) > 0\r\n ) q1 ON trip.trip_id = q1.trip_id \r\n /*в аравал сташон скорее всего ашибка*/\r\n JOIN route as l on q1.trip_id = l.trip_id AND arrival_station = l.station_name\r\n  JOIN route as r on q1.trip_id = r.trip_id AND departure_station = r.station_name;'
            cur.execute(from_to)
            result_from_to = cur.fetchall()
            for row1 in result_from_to:
                tmp = [row1[3], row1[4], row1[1], row1[12], row1[17]]
                print(row1[5])
                print(date_)
                if row1[5].strftime("%Y-%m-%d") == date_:
                    print("dffslag")
                    bd_by_from_to.append(tmp)

            return render_template("index.html", bd=bd_by_from_to)
        else:
            print("flAaaaAAg")
            print(from_)
            print(to_)
            from_to = f'\r\nSELECT * FROM trip JOIN (\r\nSELECT tmp1.trip_id, tmp1.train_number  FROM (\r\nSELECT * FROM route WHERE trip_id IN (\r\n  SELECT trip_id\r\n            FROM \r\n              route \r\n            WHERE \r\n              station_name LIKE \"%{from_}%\" \r\n              OR station_name LIKE \"%{to_}%\" \r\n            GROUP BY \r\n              train_number \r\n            HAVING \r\n              COUNT(*) > 1\r\n) AND station_name LIKE \"%{from_}%\" \r\n  OR station_name LIKE \"%{to_}%\" \r\n ORDER BY trip_id, arrival_time ) tmp1 JOIN \r\n(\r\nSELECT * FROM route WHERE trip_id IN (\r\n  SELECT trip_id\r\n            FROM \r\n              route \r\n            WHERE \r\n              station_name LIKE \"%{from_}%\" \r\n              OR station_name LIKE \"%{to_}%\" \r\n            GROUP BY \r\n              train_number \r\n            HAVING \r\n              COUNT(*) > 1\r\n) AND station_name LIKE \"%{from_}%\" \r\n  OR station_name LIKE \"%{to_}%\" \r\n ORDER BY trip_id, arrival_time DESC) tmp2 ON tmp1.station_name LIKE \"%{from_}%\" and tmp2.station_name LIKE \"%{to_}%\" AND tmp1.trip_id = tmp2.trip_id\r\n WHERE timediff(tmp2.arrival_time, tmp1.arrival_time) > 0\r\n ) q1 ON trip.trip_id = q1.trip_id \r\n /*в аравал сташон скорее всего ашибка*/\r\n JOIN route as l on q1.trip_id = l.trip_id AND arrival_station = l.station_name\r\n  JOIN route as r on q1.trip_id = r.trip_id AND departure_station = r.station_name;'
            cur.execute(from_to)
            result_from_to = cur.fetchall()
            i = 0
            # ["(by from_to) c0", "c1", "C001", "7:55", "12:10", "10.12.22"],
            for row1 in result_from_to:
                print(row1)
                tmp = [row1[3], row1[4], row1[1], row1[12], row1[17]]
                bd_by_from_to.append(tmp)
            return render_template("index.html", bd=bd_by_from_to)

    station_ = request.args.get("station_")
    if station_:
        station_ = station_.strip()
    bd_by_station.clear()
    if (station_):
        if (date_):
            station_name = f'SELECT * FROM (\r\nSELECT q2.trip_id, q2.train_number, q2.departure_time, q2.arrival_time, tmp.station_name as depature_station, tmp2.station_name as arrival_station FROM (\r\n    SELECT trip_id, train_number, MIN(arrival_time) as departure_time, MAX(arrival_time) as arrival_time FROM (\r\n        SELECT * FROM route\r\n        ORDER BY trip_id, arrival_time\r\n  ) q1\r\n  GROUP BY trip_id, train_number\r\n  having q1.trip_id IN (SELECT DISTINCT trip_id FROM route\r\n      WHERE station_name LIKE \"%{station_}%\")\r\n) q2 JOIN \r\n(SELECT trip_id, station_name, arrival_time FROM route) tmp ON q2.trip_id = tmp.trip_id and q2.departure_time = tmp.arrival_time\r\nJOIN (SELECT trip_id, station_name, arrival_time FROM route) tmp2 on q2.trip_id = tmp2.trip_id and q2.arrival_time = tmp2.arrival_time\r\n) аоо WHERE DATE(departure_time) = "{date_}";'
            cur.execute(station_name)
            result_station_name = cur.fetchall()
            for row1 in result_station_name:
                print(row1)
                tmp = [row1[4], row1[5], row1[1], row1[2], row1[3]]
                bd_by_station.append(tmp)
            return render_template("index.html", bd=bd_by_station)
        else:
            station_name = f'SELECT * FROM (\r\nSELECT q2.trip_id, q2.train_number, q2.departure_time, q2.arrival_time, tmp.station_name as depature_station, tmp2.station_name as arrival_station FROM (\r\n    SELECT trip_id, train_number, MIN(arrival_time) as departure_time, MAX(arrival_time) as arrival_time FROM (\r\n        SELECT * FROM route\r\n        ORDER BY trip_id, arrival_time\r\n  ) q1\r\n  GROUP BY trip_id, train_number\r\n  having q1.trip_id IN (SELECT DISTINCT trip_id FROM route\r\n      WHERE station_name LIKE \"%{station_}%\")\r\n) q2 JOIN \r\n(SELECT trip_id, station_name, arrival_time FROM route) tmp ON q2.trip_id = tmp.trip_id and q2.departure_time = tmp.arrival_time\r\nJOIN (SELECT trip_id, station_name, arrival_time FROM route) tmp2 on q2.trip_id = tmp2.trip_id and q2.arrival_time = tmp2.arrival_time\r\n) аоо;'
            cur.execute(station_name)
            result_station_name = cur.fetchall()
            for row1 in result_station_name:
                print(row1)
                tmp = [row1[4], row1[5], row1[1], row1[2], row1[3]]
                bd_by_station.append(tmp)
            return render_template("index.html", bd=bd_by_station)

    number_ = request.args.get("number_")
    if number_:
        number_ = number_.strip()
    bd_by_number.clear()
    if (number_):
        if (date_):
            print(date_)
            train_num = f'SELECT * FROM (\r\nSELECT q2.train_number, q2.departure_time, q2.arrival_time, tmp.station_name as depature_station, tmp2.station_name as arrival_station FROM (\r\n    SELECT trip_id, train_number, MIN(arrival_time) as departure_time, MAX(arrival_time) as arrival_time FROM (\r\n        SELECT * FROM route\r\n        ORDER BY trip_id, arrival_time\r\n  ) q1\r\n  GROUP BY trip_id, train_number\r\n) q2 JOIN \r\n(SELECT trip_id, station_name, arrival_time FROM route) tmp ON q2.trip_id = tmp.trip_id and q2.departure_time = tmp.arrival_time\r\nJOIN (SELECT trip_id, station_name, arrival_time FROM route) tmp2 on q2.trip_id = tmp2.trip_id and q2.arrival_time = tmp2.arrival_time\r\n) аоо\r\nWHERE train_number LIKE \"%{number_}%\" AND DATE(departure_time) = "{date_}";'
            cur.execute(train_num)
            result_train_num = cur.fetchall()
            for row1 in result_train_num:
                print(row1)
                tmp = [row1[3], row1[4], row1[0], row1[1], row1[2]]
                bd_by_number.append(tmp)

            return render_template("index.html", bd=bd_by_number)
        else:
            train_num = f'SELECT * FROM (\r\nSELECT q2.train_number, q2.departure_time, q2.arrival_time, tmp.station_name as depature_station, tmp2.station_name as arrival_station FROM (\r\n    SELECT trip_id, train_number, MIN(arrival_time) as departure_time, MAX(arrival_time) as arrival_time FROM (\r\n        SELECT * FROM route\r\n        ORDER BY trip_id, arrival_time\r\n  ) q1\r\n  GROUP BY trip_id, train_number\r\n) q2 JOIN \r\n(SELECT trip_id, station_name, arrival_time FROM route) tmp ON q2.trip_id = tmp.trip_id and q2.departure_time = tmp.arrival_time\r\nJOIN (SELECT trip_id, station_name, arrival_time FROM route) tmp2 on q2.trip_id = tmp2.trip_id and q2.arrival_time = tmp2.arrival_time\r\n) аоо\r\nWHERE train_number LIKE \"%{number_}%\";'
            cur.execute(train_num)
            result_train_num = cur.fetchall()
            i = 0

            # maxdate = datetime(1, 1, 1, 1, 1, 1)
            # mindate = datetime(2040, 1, 1, 1, 1, 1)
            # for row1 in result_train_num:
            #     if row1[4] > maxdate:
            #         maxdate = row1[4]
            #     if row1[4] < mindate:
            #         mindate = row1[4]
            # exp_bd = result_train_num
            # exp_bd = [list(row) for row in exp_bd]
            # list(exp_bd)
            # for row in exp_bd:
            #     row[3] = datetime.combine(row[3], datetime.time(mindate))
            #     row[4] = datetime.combine(row[4], datetime.time(maxdate))
            #     # row[4] = maxdate.strftime(" %Y/%m/%d %H:%M")
            for row1 in result_train_num:
                print(row1)
                tmp = [row1[3], row1[4], row1[0], row1[1], row1[2]]
                bd_by_number.append(tmp)
            return render_template("index.html", bd=bd_by_number)
    bd_by_number.clear()

    print(from_, to_, station_, number_, date_)

    return render_template("index.html", bd=bd)


@app.route('/way/<number>')
def way(number):
    train_route = f'SELECT station_name, arrival_time, arrival_time FROM route \
                    WHERE train_number = "{number}";'
    cur.execute(train_route)
    result_train_route = cur.fetchall()
    # ["station1", "12.15", "1ч10м", "10.12.2022"]
    result_train_route = [list(row) for row in result_train_route]
    list(result_train_route)
    for row in result_train_route:
        print(row)
        row[1] = row[1].time()
        row[2] = row[2].date()
    return render_template("way.html", way=result_train_route)


app.run(host='0.0.0.0', port=81, debug=True)

cnx.close()

# try:
#     with connect(
#         host="localhost",
#         user=input("Имя пользователя: "),
#         password=getpass("Пароль: "),
#         database="real_trains"
#     ) as connection:
#         show_db_query = "SHOW DATABASES"
#         the_query = "SELECT * FROM route LIMIT 100"
#         with connection.cursor() as cursor:
#             cursor.execute(the_query)
#             result = cursor.fetchall()
#             for row in result:
#                 print(row)
# except Error as e:
#     print(e)
