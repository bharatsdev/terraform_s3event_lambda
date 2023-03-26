exports.handler = (event, context) => {
    console.log('Capture S3 Event create update delete though aws lambda')
    console.log('Event: ', JSON.stringify(event));
    console.log('Context: ', JSON.stringify(context));

    return {
        statusCode: 200,
        body: JSON.stringify(event),
    };
};