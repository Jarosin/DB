import mysql.connector
from mysql.connector import Error
import pandas as pd
from DBManager import *

DB = DBManager("zoo", "bmstu", "qwerty", "127.0.0.1", "5432")
