1.월을 대문자로 변환할 것
cap_month() {
case "$1" in
    january) echo "January";;
    february) echo "February";;
    march) echo "March";;
    april) echo "April";;
    may) echo "May";;
    june) echo "June";;
    july) echo "July";;
    august) echo "August";;
    september) echo "September";;
    october) echo "October";;
    november) echo "November";;
    december) echo "December";;
    *) echo "Invalid month";;

esac
}
2.월의 형태가 모두 가능하게 할 것
change_month() {
case "$1" in
    1|jan|january)  echo "Jan" ;;
    2|feb|february) echo "Feb" ;;
    3|mar|march) echo "Mar" ;;
    4|apr|april) echo "Apr" ;;
    5|may) echo "May" ;;
    6|jun|june) echo "Jun" ;;
    7|jul|july) echo "Jul" ;;
    8|aug|august) echo "Aug" ;;
    9|sep|september) echo "Sep" ;;
    10|oct|october) echo "Oct" ;;
    11|nov|november) echo "Nov" ;;
    12|dec|december) echo "Dec" ;;
    *) echo "Invalid month" ;;

esac
}
3.윤년인지 판별할 것
is_leap_year() {
  year=$1
  if (( year % 4 != 0 )); then
    echo 0
  elif (( year % 400 == 0 )); then
    echo 1
  elif (( year % 100 == 0 )); then
    echo 0
  else
    echo 1
  fi
}
4. 각 달의 일 수 정하기
days_in_month() {
  month=$1
  year=$2
  case "$month" in
    Jan) echo 31 ;;
    Feb)
      if [ "$(is_leap_year $year)" -eq 1 ]; then
        echo 29
      else
        echo 28
      fi
      ;;
    Mar) echo 31 ;;
    Apr) echo 30 ;;
    May) echo 31 ;;
    Jun) echo 30 ;;
    Jul) echo 31 ;;
    Aug) echo 31 ;;
    Sep) echo 30 ;;
    Oct) echo 31 ;;
    Nov) echo 30 ;;
    Dec) echo 31 ;;
  esac
}
5.인수가 3개가 아닐 경우 종료 코드로 프로그램 끝내기
if [ "$#" -ne 3 ]; then
  echo "입력값 오류"
  exit 1
fi
