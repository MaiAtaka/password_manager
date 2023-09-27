#!/bin/bash

file="password-manager-store.txt"

echo "パスワードマネージャーへようこそ!"

while true; do
    read -p "次の選択肢から入力してください(Add Password/Get Password/Exit)：" choice

    # もしAdd Passwordが入力されたら
    if [[ "${choice}" == "Add Password" ]]; then
        # サービス名、ユーザー名、パスワードの入力を求める
        read -p "サービス名を入力してください：" service
        read -p "ユーザー名を入力してください：" username
        read -p "パスワードを入力してください：" password
        echo ""
        # 入力された情報をファイルに保存する
        echo "${service}:${username}:${password}" >> $file
        echo "パスワードの追加は成功しました。"

    # もしGet Passwordが入力されたら
    elif [[ "${choice}" == "Get Password" ]]; then
        # サービス名を入力してください
        read -p "サービス名を入力してください：" service

        # grepを使用してサービス名を検索し、対応する行を表示
        result=$(grep --no-messages "^${service}:" $file)

        # 結果が空でない場合、該当する行を表示
        if [ -n "$result" ]; then
            # サービス名、ユーザー名、パスワードを抽出して表示
            saved_username=$(echo "$result" | cut -d ':' -f 2)
            saved_password=$(echo "$result" | cut -d ':' -f 3)
            echo "サービス名: $service"
            echo "ユーザー名: $saved_username"
            echo "パスワード: $saved_password"
        else
            echo "そのサービスは登録されていません。"
        fi

    # もしExitが入力されたら
    elif [[ "${choice}" == "Exit" ]]; then
        echo "Thank you!"
        break

    else
        echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
    fi
done
