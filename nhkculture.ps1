##### もろもろ設定
$title = '文学の世界'
# 31分×60秒録音
$recording_seconds = 31 * 60
# vlcのインストールディレクトリ
$vlcexe = 'C:\Program Files\VideoLAN\VLC\vlc.exe'
# らじるらじるでストリーム放送しているURL（ラジオ第二）
$openurl = 'https://nhkradioakr2-i.akamaihd.net/hls/live/511929/1-r2/1-r2-01.m3u8'
# M4Aファイルを保存するディレクトリ
$destdir = 'E:\music\nhk-bungei\'

# 起動した日時
$date = Get-Date
$time = $date.ToString("HHmmss")
$yobi = [System.Convert]::ToInt32(($date).DayOfWeek)

# 次回放送は？
# - 木曜20時30分～21時00分

function getNextCast{
    switch ($yobi){
        0 {
            # 日曜日 "次回は4日後の夜"
            [DateTime]$val = (Get-Date $date.AddDays(4) -Hour 20 -Minute 29 -Second 30)
            return $val; break}
        1 {
            # 月曜日 "次回は3日後の夜"
            [DateTime]$val = (Get-Date $date.AddDays(3) -Hour 20 -Minute 29 -Second 30)
            return $val; break}
        2 {
            # 火曜日 "次回は2日後の夜"
            [DateTime]$val = (Get-Date $date.AddDays(2) -Hour 20 -Minute 29 -Second 30)
            return $val; break}
        3 {
            # 水曜日　"次回は明日の夜"
            [DateTime]$val = (Get-Date $date.AddDays(1) -Hour 20 -Minute 29 -Second 30)
            return $val; break}
        4 {
            if ([int]$time -lt 202900) {
            # 木曜日 "次回は今日の夜"
            [DateTime]$val = (Get-Date -Hour 20 -Minute 29 -Second 30)
            return $val
            } else {
            # 木曜日 "次回は一週間後の木曜"
            [DateTime]$val = (Get-Date $date.AddDays(7) -Hour 20 -Minute 29 -Second 30)
            return $val
            }
            break}
         5 {
            # 金曜日 "次回は6日後の夜"
            [DateTime]$val = (Get-Date $date.AddDays(6) -Hour 20 -Minute 29 -Second 30)
            return $val; break}
         6 {
            # 土曜日 "次回は5日後の夜"
            [DateTime]$val = (Get-Date $date.AddDays(5) -Hour 20 -Minute 29 -Second 30)
            return $val; break}
    }
}

function getSleepSecond([DateTime]$nc){
  # 次回まで何秒なのか
  $ss = ([DateTime]$nc - $date).TotalSeconds
  return $ss
}

function startRec{
  Start-Process -FilePath $vlcexe -ArgumentList "-I dummy $openurl :sout=#transcode{acodec=mp3,ab=128}:file{dst=$destfile,no-overwrite} --run-time=$recording_seconds vlc://quit" -Wait
}

# ====main procedure====
# 次回放送日時を取得する
[DateTime]$next_casting = getNextCast

# ファイル名決定
$destfile = $destdir + $title + "　" + $next_casting.AddSeconds(30).ToString("yyyyMMdd-HHmm") + ".mp3"

# 次回放送日時まで待機する
$sleep_seconds = getSleepSecond $next_casting
Start-Sleep -s $sleep_seconds

# 次回放送日時の30秒前に録音実行
startRec
