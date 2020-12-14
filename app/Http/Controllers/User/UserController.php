<?php
namespace App\Http\Controllers\User;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;

class UserController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function show($id)
    {
        $user = User::find($id);

        if($user){
            return response()->json([
                'success' => true,
                'message' => 'User Found',
                'user' => $user
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'User Not Found',
                'user' => ''
            ], 404);
        }
    }
}