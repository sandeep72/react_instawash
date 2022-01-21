<?php

use App\Models\Service_type;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\models\Customer;
use App\models\Incident;
use App\models\Order;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


Route::get('/login.php', function (Request $request) {
    // $email = $_REQUEST["username"];
    // $password = $_REQUEST["password"];
    // $result = DB::statement("select * from customers where email= '" . $email . "' and password = '" . $password . "'"); // where id= '$email' and password = '$password'");

    // // return $result;
    // if ($result == true)
    //     return response()->json(["status" => "true"]);
    // else
    //     return response()->json(["status" => "false", "msg" => "Invalid username and password"]);

    $con = mysqli_connect("localhost", "root", "root1234", "instawash");

    if ($con) {
        $email = $request["username"];
        $password = $request["password"];
        if (strpos($email, '@iw.com')) {
            $sql = "SELECT * FROM `personnels` where email = '$email' and password='$password';";
        } else {
            $sql = "SELECT * FROM `customers` where email = '$email' and password='$password';";
        }
        $result = $con->query($sql);
        if ($result->num_rows > 0) {
            $currentUser = (object)[];
            while ($row = $result->fetch_assoc()) {
                $currentUser = $row;
            }
            return (json_encode($currentUser));
        } else {
            return (json_encode(["status" => "false"]));
        }
    }
});

Route::get('/register.php', function (Request $request) {
    $name = $request["name"];
    $email = $request["email"];
    $password =  $request["password"];
    $mobile_no =  $request["mobileNo"];
    $address =  $request["address"];
    $gender = 'Male';
    $doj = date('Y-m-d');

    $result = Customer::where('email', $email)->get();
    if (count($result) > 0) {
        return json_encode(["status" => "false", "msg" => "user with email already exists"]);
    } else {

        $result = DB::statement("INSERT INTO customers ( `name`, `doj`, `email`, `password`, `mobile_no`, `gender`, `type`, `address`)
         values('" . $name . "','" . $doj . "','" . $email . "','" . $password . "'," . $mobile_no . ",'" . $gender . "','customer','" . $address . "');");
        if ($result == true)
            return response()->json(["status" => "true"]);
        else
            return response()->json(["status" => "false", "msg" => "error inserting in to DB"]);
    }
});

// Order related API's: section start
Route::get('/orders/show_all_orders.php', function (Request $request) {

    $request->headers->set('Accept', 'application/json');
    if ($request->has("admin")) {
        $results = Order::all();
    } else {
        $customer_id = $request["customerId"];
        $results = Order::where('customer_id', $customer_id)->get(); //DB::select("select * from orders where customer_id = '" . $customer_id . "';");
    }
    $i = 0;
    $response = [];
    foreach ($results    as  $row) {
        $response[$i]['id'] = (string)$row['id'];
        $response[$i]['customer_id'] = (string)$row['customer_id'];
        $response[$i]['service_type'] = $row['service_type'];
        $response[$i]['date'] = $row['date'];
        $response[$i]['weight'] = (string)$row['weight'];
        $response[$i]['pickup_address'] = (string) $row['pickup_address'];
        $response[$i]['amount'] = (string)$row['amount'];
        $response[$i]['tax'] = (string)$row['tax'];
        $response[$i]['penalty'] = (string)$row['penalty'];
        $response[$i]['total'] = (string) $row['total'];
        $response[$i]['payment_type'] = $row['payment_type'];
        $response[$i]['payment_status'] = $row['payment_status'];
        $response[$i]['order_type'] = $row['order_type'];
        $response[$i]['pickup_time'] = $row['pickup_time'];
        $response[$i]['delivery_time'] = $row['delivery_time'];
        $response[$i]['customer_pickup_time'] = $row['customer_pickup_time'];
        $response[$i]['delayed_pickup'] = $row['delayed_pickup'];
        $response[$i]['status'] = $row['status'];
        $i++;
    }
    return json_encode($response, JSON_PRETTY_PRINT);
});


Route::get('/orders/create_new_order.php', function (Request $request) {
    $request->headers->set('Accept', 'application/json');
    date_default_timezone_set('America/Chicago');
    $customer_id = $request["customerId"];
    $service_type = $request["service_type"];
    $date = $request["date"];
    $weight = $request["weight"];
    $pickup_address = $request["pickup_address"];
    $tax = $request["tax"];
    $amount = $request["amount"];
    $total = $request["total"];
    $payment_type = $request["payment_type"];
    $order_type = "Online";
    $pickup_time = $request["pickup_time"];   // hh:mm:ss
    $status = "NEW";
    $delivery_time = $pickup_time;

    $timestamp = strtotime($delivery_time) + 60 * 60 * 3;
    $delivery_time = date('H:i', $timestamp);

    // validations
    if ($date < date('Y-m-d')) {
        return json_encode(["status" => "false", "msg" => "date cannot be a past date"]);
    }
    if ((float)$weight < 0) {
        return json_encode(["status" => "false", "msg" => "weight cannot be negative"]);
    }
    if ($date === date('Y-m-d') and $pickup_time < date('H:i')) {
        return json_encode(["status" => "false", "msg" => "pickup time cannot be from past"]);
    }
    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    $sql = "INSERT INTO `orders`(`customer_id`, `service_type`, `date`, `weight`, `pickup_address`, `amount`, `tax`,
            `penalty`, `total`,`payment_type`, `order_type`, `pickup_time`, `delivery_time`, `customer_pickup_time`, `delayed_pickup`, `status`)
            values('$customer_id', '$service_type', '$date', $weight, '$pickup_address', $amount,'$tax',
            0,$total, '$payment_type','$order_type','$pickup_time', '$delivery_time','','','$status');";  // shall we extend it with condition on status field.

    $result = mysqli_query($con, $sql);
    if ($result === TRUE) {
        return json_encode(["status" => "true"]);
    } else {
        return json_encode(["status" => "false", "msg" => "error inserting data to DB"]); // code : 0 , error placing order
    }
});


Route::get('/orders/update_order.php', function (Request $request) {



    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {
        $id = $request["id"];
        $customer_id = $request["customer_id"];
        $service_type = $request["service_type"];
        $date = $request["date"];
        $weight = $request["weight"];
        $pickup_time = $request["pickup_time"];

        date_default_timezone_set('America/Chicago');
        if ($date < date('Y-m-d')) {
            return (json_encode(["status" => "false", "msg" => "date cannot be a past date"]));
        }
        if ($date === date('Y-m-d') and $pickup_time < date('H:i')) {
            return (json_encode(["status" => "false", "msg" => "pickup time cannot be from past"]));
        }
        if ((float)$weight < 0) {
            return (json_encode(["status" => "false", "msg" => "weight cannot be negative"]));
        }

        $status = $_GET["status"] ?: "NEW";

        $sql = "select * from orders where id = '$id' and customer_id = '$customer_id';";  // shall we extend it with condition on status field.
        $result = mysqli_query($con, $sql);
        if ($result->num_rows == 0) {
            return (json_encode(["status" => "false"]));   // code : 0 , no record found
        } else {
            $sql = "update orders set service_type = '$service_type', date = '$date', weight = $weight, pickup_time = '$pickup_time', status = '$status'
         where id = '$id' and customer_id = '$customer_id'";
            $result = mysqli_query($con, $sql);
            if ($result === TRUE) {
                return (json_encode(["status" => "true"]));
            } else {
                return (json_encode(["status" => "false", "msg" => "error inserting data to DB"]));
            }
        }
    } else {
        return (json_encode(["status" => "false", "msg" => "error connecting to DB"]));    // code 3 for error connecting to DB.
    }
});

Route::get('/orders/delete_order.php', function (Request $request) {

    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {
        $id = $request["id"];
        $customer_id = $request["customer_id"];

        $sql = "Delete from orders where id = '$id' and customer_id = $customer_id ;";  // shall we extend it with condition on status field.
        $result = mysqli_query($con, $sql);
        if ($result === TRUE) {
            return (json_encode(["status" => "true"]));
        } else {
            return (json_encode(["status" => "false"]));
        }
    } else {
        return (json_encode(["status" => "false"]));    // code 3 for error connecting to DB.
    }
});

Route::get('/orders/service_types.php', function (Request $request) {

    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {
        $sql  = "select * from service_types;";
        $result = mysqli_query($con, $sql);
        if ($result) {
            header("content-type: JSON");

            $i = 0;
            $response = [];
            while ($row = mysqli_fetch_assoc($result)) {
                $response[$i]['id'] = (string)$row['id'];
                $response[$i]['service_type'] = $row['service_type'];
                $response[$i]['rate_per_pound'] = (string)$row['rate_per_pound'];
                $i++;
            }

            return (json_encode($response, JSON_PRETTY_PRINT));
        } else {
            return (json_encode(["status" => "false"]));    // code 0 no records available in the table
        }
    } else {
        return (json_encode(["status" => "false"]));    // code 3 for error connecting to DB.
    }
});

// Order related API's: section end

// Admin related API's: section start

Route::get('/admin/delete_employee.php', function (Request $request) {
    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {
        $id = $request["id"];
        $email = $request["email"];

        $sql = "Delete from personnels where id = '$id' and email = '$email';";  // shall we extend it with condition on status field.
        $result = mysqli_query($con, $sql);
        if ($result === TRUE) {
            return (json_encode(["status" => "true"]));
        } else {
            return (json_encode(["status" => "false"]));
        }
    } else {
        return (json_encode(["status" => "false"]));    // code 3 for error connecting to DB.
    }
});

Route::get('/admin/get_customer_list.php', function (Request $request) {
    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {

        $sql  = "select * from customers;";
        $result = mysqli_query($con, $sql);
        if ($result) {
            header("content-type: JSON");
            $i = 0;
            $response = [];
            while ($row = mysqli_fetch_assoc($result)) {
                $response[$i]['id'] = (string)$row['id'];
                $response[$i]['name'] = $row['name'];
                $response[$i]['email'] = $row['email'];
                $response[$i]['doj'] = $row['doj'];
                $response[$i]['address'] = $row['address'];
                $response[$i]['mobile_no'] = (string)$row['mobile_no'];
                $response[$i]['gender'] = $row['gender'];
                $response[$i]['img'] = $row['img'];
                $i++;
            }
            return (json_encode($response, JSON_PRETTY_PRINT));
        } else {
            return (json_encode(["status" => "false", "msg" => "no records available"]));    // code 0 no records available in the table
        }
    } else {
        return (json_encode(["status" => "false", "msg" => "error connecting to DB"]));    // code 3 for error connecting to DB.
    }
});

Route::get('/admin/get_employee_list.php', function (Request $request) {

    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {

        $sql  = "select * from personnels where type <> 'admin';";
        $result = mysqli_query($con, $sql);
        if ($result) {
            header("content-type: JSON");
            $i = 0;
            $response = [];
            while ($row = mysqli_fetch_assoc($result)) {
                $response[$i]['id'] = (string)$row['id'];
                $response[$i]['name'] = $row['name'];
                $response[$i]['doj'] = $row['doj'];
                $response[$i]['address'] = $row['address'];
                $response[$i]['type'] = $row['type'];
                $response[$i]['ssn'] = (string)$row['ssn'];
                $response[$i]['mobile_no'] = (string)$row['mobile_no'];
                $response[$i]['gender'] = $row['gender'];
                $response[$i]['email'] = $row['email'];
                $response[$i]['password'] = $row['password'];
                $response[$i]['img'] = $row['img'];
                $i++;
            }
            return (json_encode($response, JSON_PRETTY_PRINT));
        } else {
            return (json_encode(["status" => "false", "msg" => "no records available"]));    // code 0 no records available in the table
        }
    } else {
        return (json_encode(["status" => "false", "msg" => "error connecting to DB"]));    // code 3 for error connecting to DB.
    }
});


Route::get('/admin/get_incident_list_admin.php', function (Request $request) {
    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {
        $sql  = "select * from incidents;";
        $result = mysqli_query($con, $sql);
        if ($result) {
            header("content-type: JSON");
            $i = 0;
            $response = [];
            while ($row = mysqli_fetch_assoc($result)) {
                $response[$i]['id'] = (string)$row['id'];
                $response[$i]['status'] = $row['status'];
                $response[$i]['description'] = $row['description'];
                $response[$i]['solution'] = $row['solution'];
                $response[$i]['date'] = $row['date'];
                $response[$i]['order_id'] = (string) $row['order_id'];
                $i++;
            }
            return (json_encode($response, JSON_PRETTY_PRINT));
        } else {
            return (json_encode(["status" => "false", "msg" => "no incident in DB"]));    // code 0 no records available in the table
        }
    } else {
        return (json_encode(["status" => "false", "msg" => "error connecting to DB"]));    // code 3 for error connecting to DB.
    }
});


Route::get('/admin/register_personnel.php', function (Request $request) {
    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {

        date_default_timezone_set('America/Chicago');
        $name = $request["name"];
        $email = $request["email"];
        $password =  $request["password"];
        $mobile_no =  $request["mobile_no"];
        $address =  $request["address"];
        $gender = $request["gender"];
        $doj = date('Y-m-d');
        $address =  $request["address"];
        $type = $request["type"];
        $ssn = $request["ssn"];

        //standard email validation as per RFC 822 grammar 
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            return (json_encode(["status" => "false", "msg" => "invalid email address"]));
        }

        if (!strlen($mobile_no) == 10 and !is_numeric($mobile_no)) {
            return (json_encode(["status" => "false", "msg" => "invalid mobile number"]));
        }


        if ($doj > date('Y-m-d')) {
            return (json_encode(["status" => "false", "msg" => "date cannot be a future date"]));
        }


        $sql = "select * from personnels where email = '$email';";



        $result = mysqli_query($con, $sql);
        if ($result->num_rows > 0) {
            return (json_encode(["status" => "false", "msg" => "email already exists"]));
            echo "exists";
        } else {
            $sql = "INSERT INTO personnels (`name`, `doj`, `email`, `password`, `type`, `ssn`, `gender`, `address`, `mobile_no`, `img`)
                values('$name', '$doj', '$email', '$password','$type', '$ssn', '$gender',  '$address','$mobile_no', 'https://sxy5732.uta.cloud/WDM/admin/default.png' );";
            $result = mysqli_query($con, $sql);
            if ($result === TRUE) {
                return (json_encode(["status" => "true"]));
            } else {
                return (json_encode(["status" => "false", "msg" => "error conencting to DB"]));
            }
        }
    } else {
        return (json_encode(["status" => "false", "msg" => "error conencting to DB"]));    // code 3 for error connecting to DB.
    }
});

Route::get('/admin/update_employee.php', function (Request $request) {

    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {
        date_default_timezone_set('America/Chicago');
        $id = $request["id"];
        $type = $request["type"];
        $address = $request["address"];
        $mobile_no = $request["mobile_no"];
        $img = $request['img'];

        if (!strlen($mobile_no) == 10 and !is_numeric($mobile_no)) {
            return (json_encode(["status" => "false", "msg" => "invalid mobile number"]));
        }

        $sql = "update personnels set type = '$type', address = '$address', mobile_no = '$mobile_no', img='$img' where id = '$id'";
        $result = mysqli_query($con, $sql);
        if ($result) {

            $sql  = "select * from personnels where id = '$id';";
            $result = mysqli_query($con, $sql);

            if ($result) {
                header("content-type: JSON");
                $i = 0;
                $response = [];
                while ($row = mysqli_fetch_assoc($result)) {
                    $response[$i]['id'] = (string)$row['id'];
                    $response[$i]['name'] = $row['name'];
                    $response[$i]['doj'] = $row['doj'];
                    $response[$i]['address'] = $row['address'];
                    $response[$i]['type'] = $row['type'];
                    $response[$i]['ssn'] = (string)$row['ssn'];
                    $response[$i]['mobile_no'] = (string)$row['mobile_no'];
                    $response[$i]['gender'] = $row['gender'];
                    $response[$i]['email'] = $row['email'];
                    $response[$i]['password'] = $row['password'];
                    $response[$i]['img'] = $row['img'];
                    $i++;
                }
                return (json_encode($response, JSON_PRETTY_PRINT));
            } else {
                return (json_encode(["status" => "false", "msg" => "could not read entry"]));    // code 0 no records available in the table
            }
        } else {
            return (json_encode(["status" => "false", "msg" => "error updating record"]));
        }
        // }
    } else {
        return (json_encode(["status" => "false", "msg" => "error connecting to DB"]));    // code 3 for error connecting to DB.
    }
});

// Admin related API's: section end

// Customer related API's: section start
Route::get('/customers/add_customer.php', function (Request $request) {

    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {

        date_default_timezone_set('America/Chicago');
        $name = $request["name"];
        $email = $request["email"];
        $password =  $request["password"] ?: "iw@" . $name;
        $mobile_no =  $request["mobile_no"];
        $address =  $request["address"];
        $gender = $request["gender"];
        $doj = $request["doj"];
        $type = $request["type"];


        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            return (json_encode(["status" => "false", "msg" => "invalid email address"]));
        }

        if (!strlen($mobile_no) == 10 and !is_numeric($mobile_no)) {
            return (json_encode(["status" => "false", "msg" => "invalid mobile number"]));
        }



        $sql = "select * from customers where email = '$email';";
        $result = mysqli_query($con, $sql);
        if ($result->num_rows > 0) {
            return (json_encode(["status" => "false", "msg" => "user already exists"]));
        } else {
            $sql = "INSERT INTO customers (`name`, `doj`, `email`, `password`, `mobile_no`, `gender`, `type`, `address`, `img`) 
                values('$name', '$doj', '$email', '$password', '$mobile_no', '$gender', '$type', '$address', `https://sxy5732.uta.cloud/WDM/customers/default.png` );";
            $result = mysqli_query($con, $sql);
            if ($result === TRUE) {
                return (json_encode(["status" => "true"]));
            } else {
                return (json_encode(["status" => "false", "msg" => "error inserting data to DB"]));
            }
        }
    } else {
        return (json_encode(["status" => "false", "msg" => "error connecting to DB"]));    // code 3 for error connecting to DB.
    }
});

Route::get('/customers/delete_customer.php', function (Request $request) {
    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {
        $id = $request["id"];
        $email = $request["email"];
        $sql = "Delete from customers where id = '$id' and email = '$email';";  // shall we extend it with condition on status field.
        $result = mysqli_query($con, $sql);
        if ($result === TRUE) {
            return (json_encode(["status" => "true"]));
        } else {
            return (json_encode(["status" => "false"]));
        }
    } else {
        return (json_encode(["status" => "false"]));    // code 3 for error connecting to DB.
    }
});

Route::get('/customers/update_customer.php', function (Request $request) {
    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {
        date_default_timezone_set('America/Chicago');
        $id = $request["id"];
        $address = $request["address"];
        $mobile_no = $request["mobile_no"];
        $gender = $request["gender"];
        $doj = $request["doj"];
        $img = $request["img"];


        if (!strlen($mobile_no) == 10 and !is_numeric($mobile_no)) {
            return (json_encode(["status" => "false", "msg" => "invalid mobile number"]));
        }


        $sql = "update customers set address = '$address', mobile_no = '$mobile_no', img='$img'  where id = '$id'";
        $result = mysqli_query($con, $sql);
        if ($result) {

            $sql  = "select * from customers;";
            $result = mysqli_query($con, $sql);
            if ($result) {
                header("content-type: JSON");
                $i = 0;
                $response = [];
                while ($row = mysqli_fetch_assoc($result)) {
                    $response[$i]['id'] = (string)$row['id'];
                    $response[$i]['name'] = $row['name'];
                    $response[$i]['email'] = $row['email'];
                    $response[$i]['doj'] = $row['doj'];
                    $response[$i]['address'] = $row['address'];
                    $response[$i]['mobile_no'] = (string)$row['mobile_no'];
                    $response[$i]['gender'] = $row['gender'];
                    $response[$i]['img'] = $row['img'];
                    $response[$i]['type'] = $row['type'];
                    $i++;
                }
                return (json_encode($response, JSON_PRETTY_PRINT));
            } else {
                return (json_encode(["status" => "false", "msg" => "error inserting data to DB"]));    // code 0 no records available in the table
            }
        } else {
            return (json_encode(["status" => "false", "msg" => "error updating entry"]));
        }
        // }
    } else {
        return (json_encode(["status" => "false", "msg" => "connection with DB failed"]));    // code 3 for error connecting to DB.
    }
});
// Customer related API's: section end

// Equipment related API's: section start
Route::get('/equipments/register_equipment.php', function (Request $request) {
    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {

        date_default_timezone_set('America/Chicago');
        $type = $request["type"];
        $brand = $request["brand"];
        $model_no =  $request["model_no"];
        $price =  $request["price"];
        $date = date('Y-m-d');

        if ((float)$price < 0) {
            return (json_encode(["status" => "false", "msg" => "price cannot be negative"]));
        }

        if ($date > date('Y-m-d')) {
            return (json_encode(["status" => "false", "msg" => "date cannot be a future date"]));
        }
        $sql = "INSERT INTO equipments (`type`, `brand`, `model_no`, `status`, `price`, `date`) values( '$type', '$brand', '$model_no', 'In Use', '$price', '$date' );";
        $result = mysqli_query($con, $sql);
        if ($result === TRUE) {
            return (json_encode(["status" => "true"]));
        } else {
            return (json_encode(["status" => "false", "msg" => "error inserting record to DB!!"]));
        }
    } else {
        return (json_encode(["status" => "false", "msg" => "error connecting to DB"]));    // code 3 for error connecting to DB.
    }
});

Route::get('/equipments/get_equipment_list.php', function (Request $request) {
    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {


        $sql  = "select * from equipments;";
        $result = mysqli_query($con, $sql);
        if ($result) {
            header("content-type: JSON");
            $i = 0;
            $response = [];
            while ($row = mysqli_fetch_assoc($result)) {
                $response[$i]['id'] = (string)$row['id'];
                $response[$i]['type'] = $row['type'];
                $response[$i]['brand'] = $row['brand'];
                $response[$i]['model_no'] = (string)$row['model_no'];
                $response[$i]['status'] = $row['status'];
                $response[$i]['price'] = (string)$row['price'];
                $response[$i]['date'] = $row['date'];
                $i++;
            }
            return (json_encode($response, JSON_PRETTY_PRINT));
        } else {
            return (json_encode(["status" => "false"]));    // code 0 no records available in the table
        }
    } else {
        return (json_encode(["status" => "false"]));    // code 3 for error connecting to DB.
    }
});

Route::get('/equipments/update_equipment.php', function (Request $request) {

    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {

        date_default_timezone_set('America/Chicago');
        $id = $request["id"];
        $type = $request["type"];
        $brand = $request["brand"];
        $model_no = $request["model_no"];
        $status = $request["status"];
        $price = $request["price"];
        $date = $request["date"];

        if ((float)$price < 0) {
            return (json_encode(["status" => "false", "msg" => "price cannot be negative"]));
        }

        if ($date > date('Y-m-d')) {
            return (json_encode(["status" => "false", "msg" => "date cannot be a future date"]));
        }


        $sql = "update equipments set type = '$type', brand = '$brand', model_no = '$model_no',
                     status = '$status' , price ='$price', date = '$date' where id = '$id'";
        $result = mysqli_query($con, $sql);
        if ($result === TRUE) {
            return (json_encode(["status" => "true"]));
        } else {
            return (json_encode(["status" => "false", "msg" => "error inserting data to DB"]));
        }
        // }
    } else {
        return (json_encode(["status" => "false", "msg" => "error connecting to DB"]));    // code 3 for error connecting to DB.
    }
});

Route::get('/equipments/delete_equipment.php', function (Request $request) {
    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {
        $id = $request["id"];

        $sql = "Delete from equipments where id = '$id' ;";  // shall we extend it with condition on status field.
        $result = mysqli_query($con, $sql);
        if ($result === TRUE) {
            return (json_encode(["status" => "true"]));
        } else {
            return (json_encode(["status" => "false", "msg" => "error deleting from table"]));
        }
    } else {
        return (json_encode(["status" => "false", "msg" => "error connecting to DB"]));    // code 3 for error connecting to DB.
    }
});
// Equipment related API's: section end


// Incident related API's: section start

Route::get('/incidents/delete_incident.php', function (Request $request) {
    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {
        $id = $request["id"];

        $sql = "Delete from incidents where id = '$id' ;";  // shall we extend it with condition on status field.
        $result = mysqli_query($con, $sql);
        if ($result === TRUE) {
            return (json_encode(["status" => "true"]));
        } else {
            return (json_encode(["status" => "false"]));
        }
    } else {
        return (json_encode(["status" => "false"]));    // code 3 for error connecting to DB.
    }
});

Route::get('/incidents/show_all_incidents.php', function (Request $request) {
    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {

        if ($request["manager"] == "true") {
            $sql  = "select * from incidents;";
        } else {
            $customer_id = $request["customerId"];
            $sql  = "select * from incidents where customer_id = '$customer_id' ;";
        }

        $result = mysqli_query($con, $sql);
        if ($result) {
            header("content-type: JSON");
            $i = 0;
            $response = [];
            // [0]['id'] = 1;
            while ($row = mysqli_fetch_assoc($result)) {
                $response[$i]['id'] = (string) $row['id'];
                $response[$i]['status'] = $row['status'];
                $response[$i]['description'] = $row['description'];
                $response[$i]['solution'] = $row['solution'];
                $response[$i]['date'] = $row['date'];
                $response[$i]['order_id'] = (string)$row['order_id'];
                $i++;
            }
            return (json_encode($response, JSON_PRETTY_PRINT));
        } else {
            return (json_encode(["status" => "false"]));    // code 0 no records available in the table
        }
    } else {
        return (json_encode(["status" => "false"]));    // code 3 for error connecting to DB.
    }
});

Route::get('/incidents/update_incident.php', function (Request $request) {
    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {

        date_default_timezone_set('America/Chicago');

        $incident_id = $request["id"];
        $status = $request["status"];
        $description = $request["description"];
        $order_id = $request["order_id"];


        $sql = "select * from incidents where id = '$incident_id' and order_id = '$order_id' and status = 'unresolved';";  // shall we extend it with condition on status field.
        $result = mysqli_query($con, $sql);
        if ($result->num_rows == 0) {
            return (json_encode(["status" => "false", "msg" => "no such incident found in DB"]));   // code : 0 , no record found
        } else {
            $sql = "update incidents set description = '$description' where id = '$incident_id' and order_id = '$order_id'";
            $result = mysqli_query($con, $sql);
            if ($result === TRUE) {
                return (json_encode(["status" => "true"]));
            } else {
                return (json_encode(["status" => "false", "msg" => "error inserting data to DB"]));
            }
        }
    } else {
        return (json_encode(["status" => "false", "msg" => "error connecting to DB"]));    // code 3 for error connecting to DB.
    }
});

Route::get('/incidents/resolve_incident.php', function (Request $request) {
    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {
        $id = $request["id"];


        $sql = "update incidents set status = 'resolved' where id = '$id'";
        $result = mysqli_query($con, $sql);
        if ($result === TRUE) {
            return (json_encode(["status" => "true"]));
        } else {
            return (json_encode(["status" => "false", "msg" => "error in updating incident detail"]));
        }
        // }
    } else {
        return (json_encode(["status" => "false", "msg" => "error in DB connenction"]));    // code 3 for error connecting to DB.
    }
});

Route::get('/incidents/register_incident.php', function (Request $request) {

    $con = mysqli_connect("localhost", "root", "root1234", "instawash");
    if ($con) {

        date_default_timezone_set('America/Chicago');
        $customer_id = $request["customerId"];
        $order_id = $request["order_id"];
        $description = $request["description"];
        $date = date('Y/m/d');

        $sql = "select * from orders where id= '$order_id'  and customer_id ='$customer_id';";
        $result = mysqli_query($con, $sql);

        if ($result->num_rows == 0) {
            return (json_encode(["status" => "false", "msg" => "Order does not belong to user"]));
        } else {

            $sql = "INSERT INTO incidents (`customer_id`, `personnel_id`, `order_id`, `status`, `description`, `solution`, `date`) values( '$customer_id', '0', '$order_id', 'unresolved', '$description', '', '$date');";
            $result = mysqli_query($con, $sql);
            if ($result === TRUE) {
                return (json_encode(["status" => "true"]));
            } else {
                return (json_encode(["status" => "false", "msg" => "error inserting data to DB"]));
            }
        }
    } else {
        return (json_encode(["status" => "false", "msg" => "error connecting to DB"]));
    }
});
// Incident related API's: section end




// image upload related API's: section start
Route::get('/image_api.php', function (Request $request) {
    $response = array();
    $upload_dir = 'uploads/';
    $server_url = "https://sxy5732.uta.cloud/WDM/";

    if ($_FILES['img']) {
        $avatar_name = $_FILES["img"]["name"];
        $avatar_tmp_name = $_FILES["img"]["tmp_name"];
        $error = $_FILES["img"]["error"];

        if ($error > 0) {
            $response = array(
                "status" => "error",
                "error" => true,
                "message" => "Error uploading the file!"
            );
        } else {
            $random_name = rand(1000, 1000000) . "-" . $avatar_name;
            $upload_name = $upload_dir . strtolower($random_name);
            $upload_name = preg_replace('/\s+/', '-', $upload_name);

            if (move_uploaded_file($avatar_tmp_name, $upload_name)) {
                $response = array(
                    "status" => "success",
                    "error" => false,
                    "message" => "File uploaded successfully",
                    "url" => $server_url . "/" . $upload_name
                );

                // $host = "utacloud2.reclaimhosting.com"; 
                $host = "localhost";
                $user = "root";
                $password = "";
                $dbname = "instawash";

                $con = mysqli_connect($host, $user, $password, $dbname);

                if (!$con) {
                    die("Connection failed: " . mysqli_connect_error());
                }

                // $sql = "insert into users (username, name, photo) values ('cairocoders', 'cairocoders Ednalan', '$upload_name')"; 
                // mysqli_query($con,$sql);
            } else {
                $response = array(
                    "status" => "error",
                    "error" => true,
                    "message" => "Error uploading the file!"
                );
            }
        }
    } else {
        $response = array(
            "status" => "error",
            "error" => true,
            "message" => "No file was sent!"
        );
    }

    return json_encode($response);
});
