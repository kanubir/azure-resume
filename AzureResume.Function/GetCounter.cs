using AzureResume.Function.Models;
using AzureResume.Function.Services;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;
using System.Net;

namespace AzureResume.Function;

public class GetCounter
{
    private readonly ILogger<GetCounter> _logger;
    private readonly ICounterService _counterService;

    public GetCounter(ILogger<GetCounter> logger, ICounterService counterService)
    {
        _logger = logger;
        _counterService = counterService;
    }

    [Function("counter")]
    [CosmosDBOutput("Resume", "Counter", Connection = "CosmosDbConnectionString", CreateIfNotExists = true)]
    public async Task<Counter> Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", "post")] HttpRequestData req,
        [CosmosDBInput("Resume", "Counter", Connection = "CosmosDbConnectionString", Id = "1", PartitionKey = "1")] Counter inputCounter)
    {
        _logger.LogInformation("Counter trigger function processed a request.");

        inputCounter = _counterService.IncrementCounter(inputCounter);

        var response = req.CreateResponse(HttpStatusCode.OK);
        await response.WriteAsJsonAsync(inputCounter);

        return inputCounter;
    }
}