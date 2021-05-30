# JudgeMe Coding Challenge - Full-stack Engineer

I considered a lot about what I should choose Rails API-only or Rails view before starting this challenge. In the end, I decided to work with Rails API because I feel more comfortable and confident. My React knowledge can support me a bit.

## 1. Challenges

First of all, I need to redesign all of endpoints `Review`, `Product`, and `Shop` to have the best performance and easily scale-up later.
I put file `.env.example` in directory, you can change it into `.env` to run it on local.

Assume that monthly avarage rating of a shop is equal to avarage of all of products. I've only finished the endpoint to return shop report. Not the whole feature.

### Development

1. `active_model_serializers`: format response payload
2. `kaminari`: pagination
3. `sidekiq & redis`: Background job
4. `rack-cors`: integrate with FE

### Test

To run the tests

```bash
rspec spec
```

1. `factory_bot_rails`: mock data to test
2. `faker`: generate fake data
3. `shoulda-matchers`: test schema endpoint
4. `rspec-sidekiq`: test sidekiq enqueue

**Happy Reviewing**
