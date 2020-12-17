<?php
namespace App\Http\Controllers\Category;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Category;

class CategoryController extends Controller
{
    public function index()
    {   
        $category = Category::all();
        foreach ($category as $object){
            $object->gambar = url('upload_foto'.'/'.$object->gambar);
        }

        return $category;
    }
}