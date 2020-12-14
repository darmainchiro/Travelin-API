<?php
namespace App\Http\Controllers\Auth;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use Illuminate\Support\Str;


class LoginController extends Controller
{
    public function __invoke(Request $request)
    {
        $this->validate($request,[
            'email' => 'required',
            'password' => 'required',
        ]);

        $user = User::where('email', $request->email)->first();

        if(Hash::check($request->password, $user->password)) {
            $apiToken = base64_encode(Str::random(40));

            $user->api_token = $apiToken;
            $user->save();
            
            return response()->json([
                'success' => true,
                'user' => $user,
                'api_token' => $apiToken
            ], 201);
        } else {
            return response()->json([
                'success' => false,
                'user' => '',
                'api_token' => ''
            ]);
        }
    }
}