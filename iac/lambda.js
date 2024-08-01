exports.handler = async (event) => {
    console.log('Received event:', JSON.stringify(event, null, 2));
 
    // Example logic: Return a response
    const response = {
        statusCode: 200,
        body: JSON.stringify('Hello from Lambda!'),
    };
    return response;
};
