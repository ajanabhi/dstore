type GraphQLResponse = {
    data?: Record<string, any>,
    errors?: { message: string }[],
  }
  
  type GraphQLEventWithParent = {
    parent: Record<string, any> | null,
    args: Record<string, any>,
    graphql: (s: string, vars: Record<string, any> | undefined) => Promise<GraphQLResponse>,
    dql: {
      query: (s: string, vars: Record<string, any> | undefined) => Promise<GraphQLResponse>
      mutate: (s: string) => Promise<GraphQLResponse>
    },
  }
  
  function addGraphQLResolvers(resolvers: {
    [key: string]: (e: GraphQLEventWithParent) => any;
  }): void
  