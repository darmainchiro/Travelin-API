<?php
namespace App\Http\Controllers\Review;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Review;

class ReviewController extends Controller
{
    public function index()
    {
        $review = Review::all();
        return $review;
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $this->validate($request,[
            'id_wisata' => ['required'],
            'id_user' => ['required'],
            'rating' => ['required']
        ]);

        $review = Review::create([
            'id_wisata' => $request->id_wisata,
            'id_user' => $request->id_user,
            'rating' => $request->rating,
            'review' => $request->review,
        ]);
    
        if($review){
            return response()->json([
                'success' => true,
                'message' => 'Terima kasih sudah mereview',
                'travel' => $review
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Gagal meriview',
                'travel' => ''
            ], 404);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $review = Review::find($id);

        if($review){
            return response()->json([
                'success' => true,
                'message' => 'Review Found',
                'review' => $review
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Review Not Found',
                'review' => ''
            ], 404);
        }

    }
}