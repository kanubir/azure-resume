using AzureResume.Function.Models;
using AzureResume.Function.Services;

namespace AzureResume.Function.Tests
{
    public class CounterServiceTests
    {
        private readonly ICounterService _counterService;

        public CounterServiceTests()
        {
            _counterService = new CounterService();
        }

        [Fact]
        public void IncrementCounter_ShouldIncreaseCountByOne()
        {
            // Arrange
            var initialCount = 10;
            var counter = new Counter("1", initialCount);

            // Act
            var result = _counterService.IncrementCounter(counter);

            // Assert
            Assert.Equal(initialCount + 1, result.Count);
        }

        [Fact]
        public void IncrementCounter_ShouldNotChangeId()
        {
            // Arrange
            var initialCount = 10;
            var counter = new Counter("1", initialCount);

            // Act
            var result = _counterService.IncrementCounter(counter);

            // Assert
            Assert.Equal("1", result.Id);
        }
    }
}
