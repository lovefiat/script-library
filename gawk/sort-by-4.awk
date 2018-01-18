
# 前処理
BEGIN {

}

# 行毎の処理
{
	if (NF < 5) {
		# フィールド数が5未満は不要
		line[NR] = "";

	} else if ($1 ~ /^[0-9-]+-/) {
		# フィールド4をソートキーに、行全体を追加
		line[NR] = $4 "\t" $0;

	} else {
		# それ以外も不要
		line[NR] = "";
	}
}

# 後処理
END {
	# 並び替え
	asort(line);
	# フォーマットしながらの出力
	for (i = 1; i < NR; i++) {
		if (line[i] != "") {
			print substr(line[i], index(line[i], "\t") + 1);
		}
	}
}
