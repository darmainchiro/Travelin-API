<?php
namespace App\Http\Controllers\Auth;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Hash;
use App\Models\User;

class RegisterController extends Controller
{
    public function __invoke(Request $request)
    {
        $this->validate($request,[
            'name' => ['string', 'required'],
            'username' => ['alpha_num', 'required', 'min:3', 'max:25', 'unique:users,username'],
            'email' => ['email', 'required', 'unique:users,email'],
            'password' => ['required', 'min:6']
        ]);

        $daftar = User::create([
           'name' =>  $request->name,
           'username' => $request->username,
           'email' => $request->email,
           'password' => Hash::make($request->password)
        ]);

        if ($daftar) {
            return response()->json([
                'success' => true,
                'data' => $daftar
            ], 201);
        }
    }
}