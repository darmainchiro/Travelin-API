<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Travel extends Model
{
    protected $table = 'category';
    protected $guarded = [];

    public function getRouteKeyName(){
        return 'id';
    }

}

