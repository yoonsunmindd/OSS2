PHONEBOOK_FILE="phonebook.txt"

search_phone_number() {
    local name="$1"
    local found="false"
    while read -r line; do
        entry_name=$(echo "$line" | cut -d ' ' -f 2)
        entry_number=$(echo "$line" | cut -d ' ' -f 3)
        if [ "$name" == "$entry_name" ]; then
            found="true"
            echo "전화번호: $entry_number"
        fi
    done < "$PHONEBOOK_FILE"
    if [ "$found" == "false" ]; then
        echo "전화번호를 찾을 수 없습니다."
    fi
}

add_phone_number() {
    echo "$1" >> "$PHONEBOOK_FILE"
    sort -o "$PHONEBOOK_FILE" "$PHONEBOOK_FILE"
    echo "새로운 전화번호가 추가되었습니다."
}

if [ ! -f "$PHONEBOOK_FILE" ]; then
    touch "$PHONEBOOK_FILE"
fi

if [ "$#" -ne 3 ]; then
    echo "사용법: $0 [이름] [전화번호] [지역번호]"
    exit 1
fi

if ! [[ "$2" =~ ^[0-9-]+$ ]]; then
    echo "전화번호는 숫자만 입력 가능합니다."
    exit 1
fi

case "$3" in
    02-*) area="서울" ;;
    051-*) area="부산" ;;
    031-*) area="경기" ;;
    042-*) area="대전" ;;
    053-*) area="대구" ;;
    *) echo "유효하지 않은 지역번호입니다." ; exit 1 ;;
esac

if grep -q "^$1 " "$PHONEBOOK_FILE"; then
    search_phone_number "$1"
    echo "이미 등록된 이름입니다."
else
    add_phone_number "$3 $1 $2 $area"
fi

exit 0