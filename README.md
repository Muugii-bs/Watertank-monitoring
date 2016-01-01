# Watertank-monitoring

### 概要
マイコンで制御される液体タンクの状態パラメータ（水位、温度など）をwifiを介して受診して、状態モニトリングやパラメータ更新などを行うipadアプリケーションです。

### 主な機能
1. マイコンのwifiモジュールと接続され、リアルタイムTCP通信を行う
2. マイコンから受信したデータをグラフ表示、リストアップなどで可視化する
3. ユーザが設定したパラメータ値をTCPチャネルを介してマイコンに送信する

### 用途、利用者
主な利用者は、工場など大型液体タンクを扱う企業などです。

### 用いた技術
1. iOS IDE（Xcode: Objective C）
2. wifi API (Objective C)
3. TCP socket (Objective C)
4. グラフ描画用 chart API（Objective C） 
