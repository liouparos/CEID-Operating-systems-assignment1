#Panagiotis Lioupis 1043795
#!/bin/bash
if [[ "$1" == "-f" && "$3" == "--edit" ]]; then
        if [[ "$5" -ge 2 && "$5" -le 8 ]]; then #.tool.sh -f <file> --edit <id> <column> <value>
	#perl -i -F, -lane 'if($.==2){$F["$5"-1]+="$6"}print join("|",@F)' $2
	final="$(awk -v id="$4" -v column="$5" -v value="$6""$7" 'BEGIN { FS=OFS="|" } $1 == id { $column = value }1' $2)"
	echo "$final" > $2
	else exit
	fi
elif [ "$5" == "-f" -a "$1" == "--edit" ]; then
        if [[ "$3" -ge 2 && "$3" -le 8 ]]; then #.tool.sh --edit <id> <column> <value> -f <file>
        final="$(awk -v id="$2" -v column="$3" -v value="$4" 'BEGIN { FS=OFS="|" } $1 == id { $column = value }1' $6)"
        echo "$final" > $6
	else exit
        fi
elif [ "$1" == "--browsers" -a "$2" == "-f" ]; then #./tool.sh --browsers -f <file>
grep -v '^#' $3 | awk -F'|' '{ print $8 }' | sort | uniq -c | tr -dc '[:print:]\n' | awk '{print $2,$3,$1}' | tr -s " "
elif [ "$3" == "--browsers" -a "$1" == "-f" ]; then #./tool.sh -f <file> --browsers
grep -v '^#' $2 | awk -F'|' '{ print $8 }' | sort | uniq -c | tr -dc '[:print:]\n' | awk '{print $2,$3,$1}' | tr -s " "
elif [ "$1" == "--born-since" -a "$3" == "--born-until" -a "$5" == "-f" ]; then #./tool.sh --born-since <dateA> --born-until <dateB> -f <file>
grep -v '^#' $6 | awk -F'|' -v A="$2" -v B="$4" '{if (A<=$5 && B>=$5) {print}}'
elif [ "$1" == "--born-until" -a "$3" == "--born-since" -a "$5" == "-f" ]; then #./tool.sh --born-until <dateB> --born-since <dateA> -f <file>
grep -v '^#' $6 | awk -F'|' -v A="$4" -v B="$2" '{if (A<=$5 && B>=$5) {print}}'
elif [ "$3" == "--born-since" -a "$5" == "--born-until" -a "$1" == "-f" ]; then #./tool.sh  -f <file> --born-since <dateA> --born-until <dateB>
grep -v '^#' $2 | awk -F'|' -v A="$4" -v B="$6" '{if (A<=$5 && B>=$5) {print}}'
elif [ "$5" == "--born-since" -a "$3" == "--born-until" -a "$1" == "-f" ]; then #./tool.sh  -f <file> --born-until <dateB> --born-since <dateA>
grep -v '^#' $2 | awk -F'|' -v A="$6" -v B="$4" '{if (A<=$5 && B>=$5) {print}}'
elif [ "$1" == "--born-since" -a "$5" == "--born-until" -a "$3" == "-f" ]; then #./tool.sh  --born-since <dateA> -f <file> --born-until <dateB>
grep -v '^#' $4 | awk -F'|' -v A="$2" -v B="$6" '{if (A<=$5 && B>=$5) {print}}'
elif [ "$5" == "--born-since" -a "$1" == "--born-until" -a "$3" == "-f" ]; then #./tool.sh  --born-until <dateB> -f <file> --born-since <dateA>
grep -v '^#' $4 | awk -F'|' -v A="$6" -v B="$2" '{if (A<=$5 && B>=$5) {print}}'
elif [ "$1" == "--born-since" -a "$3" == "-f" ]; then #./tool.sh --born-since <dateA> -f <file>
grep -v '^#' $4 | awk -F'|' -v A="$2" '{if (FNR>1 && A<=$5) {print}}'
elif [ "$1" == "-f" -a "$3" == "--born-since" ]; then #./tool.sh -f <file> --born-since <dateA>
grep -v '^#' $2 | awk -F'|' -v A="$4" '{if (FNR>1 && A<=$5) {print}}'
elif [ "$1" == "--born-until" -a "$3" == "-f" ]; then #./tool.sh --born-until <dateB> -f <file>
grep -v '^#' $4 | awk -F'|' -v B="$2" '{if (FNR>1 && B>=$5) {print}}'
elif [ "$1" == "-f" -a "$3" == "--born-until" ]; then #./tool.sh -f <file> --born-until <dateB>
grep -v '^#' $2 | awk -F'|' -v B="$4" '{if (FNR>1 && B>=$5) {print}}'
elif [ "$3" == "--lastnames" -a "$1" == "-f" ]; then #./tool.sh -f <file> --lastnames
grep -v '^#' $2 | awk -F'|' '{ print $2 }' | sort -t'|' -k 3 |sort -u
elif [ "$1" == "--lastnames" -a "$2" == "-f" ]; then #./tool.sh --lastnames -f <file>
grep -v '^#' $3 | awk -F'|' '{ print $2 }' | sort -t'|' -k 3 |sort -u
elif [ "$3" == "--firstnames" -a "$1" == "-f" ]; then #./tool.sh -f <file> --firstnames
grep -v '^#' $2 | awk -F'|' '{ print $3 }' | sort -t'|' -k 3 |sort -u
elif [ "$1" == "--firstnames" -a "$2" == "-f" ]; then #./tool.sh --firstnames -f <file>
grep -v '^#' $3 | awk -F'|' '{ print $3 }' | sort -t'|' -k 3 |sort -u
elif [ "$1" == "-f" ] & [ "$3" == "-id" ]; then #./tool.sh -f <file> -id <id>
awk -F'|' '$1 == '$4' { print $3,$2,$5 }' < "$2"
elif [ "$1" == "-id" ] & [ "$3" == "-f" ]; then #./tool.sh -id <id> -f <file>
awk -F'|' '$1 == '$2' { print $3,$2,$5 }' < "$4"
elif [ "$1" == "-f" ]; then #./tool.sh -f <file>
grep -v '^#' < $2
else
echo "1043795" #./tool.sh
fi
