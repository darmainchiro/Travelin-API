<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Travel extends Model
{
    protected $table = 'wisata';
    protected $guarded = [];

    public function getRouteKeyName(){
        return 'id';
    }

}
