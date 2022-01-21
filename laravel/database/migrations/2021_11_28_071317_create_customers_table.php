<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCustomersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('customers', function (Blueprint $table) {
            // $table->integer('id');
            // $table->string('name');
            // $table->date('doj');
            // $table->string('email');
            // $table->string('password');
            // $table->integer('mobile_no');
            // $table->string('gender');
            // $table->string('type');
            // $table->string('address');
            // $table->string('img');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('customers');
    }
}
