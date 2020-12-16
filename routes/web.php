<?php

use Illuminate\Support\Str;

/** @var \Laravel\Lumen\Routing\Router $router */

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
    return $router->app->version();
});

$router->get('/key', function() {
    return Str::random(32);
});

//Authentication
$router->post('register', 'Auth\RegisterController');
$router->post('login', 'Auth\LoginController');
$router->get('/user/{id}', 'User\UserController@show');

//Wisata
$router->group(['namespace' => 'Travel'], function() use ($router)
{
    // Using The "App\Http\Controllers\Lapangan" Namespace...
    $router->post('travel', 'TravelController@store');
    $router->patch('travel/{id}', 'TravelController@update');
    $router->delete('travel/{id}', 'TravelController@destroy');
    $router->get('travel/{id}', 'TravelController@show');
    $router->get('travel/category/{id_category}', 'TravelController@showByCategory');
    $router->get('travels', 'TravelController@index');
});
