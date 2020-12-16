# Configuration setup
url="localhost:8080"

# Create travel
method="POST"
response=$(
    http -f ${method} ${url}/travel \
    id_category=1 \
    name_wisata="Villa kahuripan" \
    description="Villa kahuripan dingin sejuk" \
    fasilitas="1. Kamar Mandi Dalam\n2. AC\n3. Kolam Renang\n4. Wifi"
    )
id=$(echo ${response} | jq -r '.travel.id' 2> /dev/null)
status=$(echo ${response} | jq -r '.success' 2> /dev/null)

if [ "$status" = "true" ]; then
    echo "${url}/travel method=${method} : CREATE TRAVEL SUCCESS"
else
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
    echo "${url}/travels method=${method} : LIST TRAVEL SUCCESS"
else
    echo "ERROR:$? => ${url}/travels method=${method} : LIST TRAVEL FAILED"
    exit $?
fi

# Show travel
method="GET"
response=$(
    http -f ${method} ${url}/travel/${id}
    )
response_id=$(echo ${response} | jq -r '.id' 2> /dev/null)
if [ "$id" = "$response_id" ]; then
    echo "${url}/travel/${id} method=${method} : SHOW DETAIL TRAVEL SUCCESS"
else
    echo "ERROR:$? => ${url}/travel/${id} method=${method} : SHOW DETAIL TRAVEL FAILED"
    exit $?
fi

# Update Category travel
method="PATCH"
response=$(
    http -f ${method} ${url}/travel/${id} \
    id_category=1 \
    name_wisata="Villa kahuripan" \
    description="Villa kahuripan tidak dingin dan sejuk" \
    fasilitas="1. Kamar Mandi Dalam\n2. AC\n3. Kolam Renang\n4. Wifi"
    )
id=$(echo ${response} | jq -r '.travel.id' 2> /dev/null)
status=$(echo ${response} | jq -r '.success' 2> /dev/null)
if [ "$status" = "true" ]; then
    echo "${url}/travel method=${method} : UPDATE TRAVEL SUCCESS"
else
    echo "ERROR:$? => ${url}/travel method=${method} : UPDATE TRAVEL FAILED"
    exit $?
fi

# Delete Travel
method="DELETE"
response=$(
    http -f ${method} ${url}/travel/${id}
    )
status=$(echo ${response} | jq -r '.success' 2> /dev/null)
if [ "$id" = "$response_id" ]; then
    echo "${url}/travel/${id} method=${method} : DELETE TRAVEL SUCCESS"
else
    echo "ERROR:$? => ${url}/travel/${id} method=${method} : DELETE TRAVEL FAILED"
    exit $?
fi