<?php
namespace App\Http\Controllers\Travel;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;
use App\Models\Travel;

class TravelController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $travel = Travel::all();
        foreach ($travel as $object){
            $object->gambar = url('upload_foto'.'/'.$object->gambar);
        }

        return $travel;
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
            'id_category' => ['required'],
            'name_wisata' => ['required'],
        ]);

        //upload foto
        if($request->file('foto')){
            $name_foto = time().$request->file('foto')->getClientOriginalName();
            //direktori
            $request->file('foto')->move('upload_foto', $name_foto);
            $foto = $name_foto;
            $id_category = $request->id_category;
            $name_wisata = $request->name_wisata;
            $description = $request->description;
            $fasilitas = $request->fasilitas;
        } else {
            $id_category = $request->id_category;
            $name_wisata = $request->name_wisata;
            $foto = 'default.png';
            $description = $request->description;
            $fasilitas = $request->fasilitas;
        }

        $travel = Travel::create([
            'id_category' => $id_category,
            'name_wisata' => $name_wisata,
            'description' => $description,
            'fasilitas' => $fasilitas,
            'gambar' => $foto,
        ]);
        
        $travel->gambar = url('upload_foto'.'/'.$foto);

        if($travel){
            return response()->json([
                'success' => true,
                'message' => 'Berhasil add travel',
                'travel' => $travel
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Tidak bisa add travel',
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

        $travel = Travel::find($id);
        $travel['gambar'] = url('upload_foto'.'/'.$travel['gambar']);
        return $travel;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $travel = Travel::findOrFail($id);
        $travel->update($request->all());

        if($travel){
            return response()->json([
                'success' => true,
                'message' => 'Berhasil update travel',
                'travel' => $travel
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Tidak bisa update travel',
                'travel' => ''
            ], 404);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $travel = Travel::find($id);
        $travel->delete();
        return response()->json([
            'success' => true,
            'message' => 'Travel sudah dihapus'
        ], 200);
    }
}