<!DOCTYPE html>
<html lang="en">
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Script Buttons</title>

    <style>
        body {
            background-color: #222;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            color: white;
        }

        button {
            background-color: #333;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            cursor: pointer;
            margin: 5px;
            border-radius: 5px;
        }
    </style>
</head>
<body>

    <button id="shatteredDreamsButton">Shattered Dreams</button>
    <button id="catsUniverseButton">Cats Universe</button>
    <button id="lucidTermButton">Lucid Term</button>

    
    <script>
        // Function to send the API request
        function sendApiRequest(scriptId) {
            console.log(`Sending API request for script ID ${scriptId}`);
        }

        // Add click event listeners to the buttons
        document.getElementById('shatteredDreamsButton').addEventListener('click', function() {
            sendApiRequest('159');
            fetch("http://127.0.0.1:9282/luar?no_debug&button=shatteredDreamsButton", {
                method: "GET" // default, so we can ignore
            })
        });

        document.getElementById('catsUniverseButton').addEventListener('click', function() {
            sendApiRequest('150');
            fetch("http://127.0.0.1:9282/luar?no_debug&button=catsUniverseButton", {
                method: "GET" // default, so we can ignore
            })
            
        });

        document.getElementById('lucidTermButton').addEventListener('click', function() {
            sendApiRequest('242');
            fetch("http://127.0.0.1:9282/luar?no_debug&button=lucidTermButton", {
                method: "GET" // default, so we can ignore
            })
        });
    </script>

</body>
</html>
