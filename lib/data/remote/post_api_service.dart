import 'package:chopper/chopper.dart';

part 'post_api_service.chopper.dart';

@ChopperApi()
abstract class PostApiService extends ChopperService {
  @Get(path: 'posts')
  Future<Response> getPosts();

  @Get(path: 'posts/{id}')
  Future<Response> getPost(@Path('id') int id);

  @Post(path: 'posts')
  Future<Response> createPost(@Body() Map<String, dynamic> body);

  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com/',
      converter: const JsonConverter(),
      services: [_$PostApiService()],
    );
    return _$PostApiService(client);
  }
}
