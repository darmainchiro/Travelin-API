# Configuration setup
#url="http://136.243.47.204:11180"
url="http://localhost:8080"

# Create travel
method="POST"
response=$(
    http -f ${method} ${url}/travel \
    id_category=1 \
    name_wisata="Villa kahuripan" \
    alamat="Kemang, Parung" \
    description="Villa kahuripan dingin sejuk" \
    fasilitas="1. Kamar Mandi Dalam\n2. AC\n3. Kolam Renang\n4. Wifi"
    )
id=$(echo ${response} | jq -r '.travel.id' 2> /dev/null)
status=$(echo ${response} | jq -r '.success' 2> /dev/null)

if [ "$status" = "true" ]; then
    echo $response | jq .
    echo "${url}/travel method=${method} : CREATE TRAVEL SUCCESS"
else
    echo $response
    echo "ERROR:$? => ${url}/travel method=${method} : CREATE TRAVEL FAILED"
    exit $?
fi

# List travel
method=GET
response=$(
    http --headers -f ${method} ${url}/travels \
    | grep HTTP | cut -d ' ' -f 2
    )
if [ "$response" = "200" ]; then
    echo $response
    echo "${url}/travels method=${method} : LIST TRAVEL SUCCESS"
else
    echo $response
    echo "ERROR:$? => ${url}/travels method=${method} : LIST TRAVEL FAILED"
    exit $?
fi

# Show travel
method="GET"
response=$(
    http -f ${method} ${url}/travel/${id}
    )
status=$(echo ${response} | jq -r '.success' 2> /dev/null)
if [ "$status" = "true" ]; then
    echo $response | jq .
    echo "${url}/travel/${id} method=${method} : SHOW DETAIL TRAVEL SUCCESS"
else
    echo $response
    echo "ERROR:$? => ${url}/travel/${id} method=${method} : SHOW DETAIL TRAVEL FAILED"
    exit $?
fi

# Update Category travel
method="PATCH"
response=$(
    http -f ${method} ${url}/travel/${id} \
    id_category=1 \
    name_wisata="Villa kahuripan" \
    alamat="Kahuripan, Kemang, Parung" \
    description="Villa kahuripan tidak dingin dan sejuk" \
    fasilitas="1. Kamar Mandi Dalam\n2. AC\n3. Kolam Renang\n4. Wifi"
    )
id=$(echo ${response} | jq -r '.travel.id' 2> /dev/null)
status=$(echo ${response} | jq -r '.success' 2> /dev/null)
if [ "$status" = "true" ]; then
    echo $response | jq .
    echo "${url}/travel/${id} method=${method} : UPDATE TRAVEL SUCCESS"
else
    echo $response
    echo "ERROR:$? => ${url}/travel/${id} method=${method} : UPDATE TRAVEL FAILED"
    exit $?
fi

# Delete Travel
method="DELETE"
response=$(
    http -f ${method} ${url}/travel/${id}
    )
status=$(echo ${response} | jq -r '.success' 2> /dev/null)
if [ "$status" = "true" ]; then
    echo $response | jq .
    echo "${url}/travel/${id} method=${method} : DELETE TRAVEL SUCCESS"
else
    echo $response
    echo "ERROR:$? => ${url}/travel/${id} method=${method} : DELETE TRAVEL FAILED"
    exit $?
fi
