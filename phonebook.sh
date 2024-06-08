PHONEBOOK="phonebook.txt"

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <name> <phone_number>"
    exit 1
fi

NAME="$1"
PHONE_NUMBER="$2"

if [[ ! "$PHONE_NUMBER" =~ ^[0-9]{2}-[0-9]{4}-[0-9]{4}$ ]]; then
    echo "유효하지 않은 전화번호입니다."
    exit 2
fi

python3 - << EOF

import sys
import os

area_codes = {
    '02': '서울',
    '031': '경기',
    '032': '인천',
    '051': '부산',
    '053': '대구'
}

def get_area(phone_number):
    prefix = phone_number.split('-')[0]
    return area_codes.get(prefix, 'Unknown')

def read_phonebook(file_path):
    phonebook = []
    if os.path.exists(file_path):
        with open(file_path, 'r') as file:
            for line in file:
                name, phone, area = line.strip().split(' ')
                phonebook.append((name, phone, area))
    return phonebook

def write_phonebook(file_path, phonebook):
    with open(file_path, 'w') as file:
        for entry in sorted(phonebook):
            file.write(f"{entry[0]} {entry[1]} {entry[2]}\n")

def main():
    if len(sys.argv) != 3:
        print("Error: 잘못된 숫자 입력입니.")
        sys.exit(1)

    name = sys.argv[1]
    phone_number = sys.argv[2]

    if not all(part.isdigit() for part in phone_number.split('-')):
        print("Error: 숫자와 하이픈만 포함.")
        sys.exit(2)

    phonebook_file = 'phonebook.txt'

    phonebook = read_phonebook(phonebook_file)

    for entry in phonebook:
        if entry[0] == name:
            if entry[1] == phone_number:
                print(f"{name} 이미 등록된 전화번호입니다.")
                sys.exit(0)
            else:
            phonebook.remove(entry)
                break


    area = get_area(phone_number)
    phonebook.append((name, phone_number, area))

    write_phonebook(phonebook_file, phonebook)
    print("전화번호가 등록되었습니다.")

if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
EOF