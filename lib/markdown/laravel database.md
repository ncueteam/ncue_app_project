# 建立資料庫

### Step1 : 更改新增的database名稱

#### 至.env檔將DB_DATABASE名稱更改為所需的

> DB_CONNECTION=mysql
>
> DB_HOST=127.0.0.1
>
> DB_PORT=3306
>
> DB_DATABASE=hotelBOT
>
> DB_USERNAME=root
>
> DB_PASSWORD

### Step2 : 新增資料表

#### 指令

> php artisan make:migration create_light_controls_table

### Step3 : 建立資料欄位

>
> return new class extends Migration
> {
>
> Schema::create('light')
>
> }
>